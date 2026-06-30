import 'package:dartz/dartz.dart';

import '../../../../core/ai/ai_orchestrator.dart';
import '../../../../core/ai/engines/budget_engine.dart';
import '../../../../core/ai/engines/currency_converter.dart';
import '../../../../core/ai/engines/expense_predictor.dart';
import '../../../../core/ai/engines/fraud_detector.dart';
import '../../../../core/ai/engines/receipt_parser.dart';
import '../../../../core/ai/engines/smart_alerts_engine.dart';
import '../../../../core/ai/engines/smart_search_engine.dart';
import '../../../../core/ai/engines/spending_analyzer.dart';
import '../../../../core/ai/engines/voice_command_parser.dart';
import '../../../../core/ai/models/ai_models.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/transaction.dart';
import '../../../transactions/domain/repositories/transactions_repository.dart';
import '../../domain/repositories/ai_repository.dart';

/// Implements all AI capabilities using local engines + orchestrator.
class AiRepositoryImpl implements AiRepository {
  AiRepositoryImpl({
    required AiOrchestrator orchestrator,
    required TransactionsRepository transactionsRepository,
    SpendingAnalyzer? spendingAnalyzer,
    BudgetEngine? budgetEngine,
    ExpensePredictor? expensePredictor,
    SmartAlertsEngine? alertsEngine,
    SmartSearchEngine? searchEngine,
    VoiceCommandParser? voiceParser,
    ReceiptParser? receiptParser,
    CurrencyConverter? currencyConverter,
    FraudDetector? fraudDetector,
    CacheStorageService? cache,
  }) : _orchestrator = orchestrator,
       _transactions = transactionsRepository,
       _spendingAnalyzer = spendingAnalyzer ?? const SpendingAnalyzer(),
       _budgetEngine = budgetEngine ?? const BudgetEngine(),
       _expensePredictor = expensePredictor ?? const ExpensePredictor(),
       _alertsEngine = alertsEngine ?? const SmartAlertsEngine(),
       _searchEngine = searchEngine ?? const SmartSearchEngine(),
       _voiceParser = voiceParser ?? const VoiceCommandParser(),
       _receiptParser = receiptParser ?? const ReceiptParser(),
       _currencyConverter = currencyConverter ?? const CurrencyConverter(),
       _fraudDetector = fraudDetector ?? const FraudDetector(),
       _cache = cache;

  final AiOrchestrator _orchestrator;
  final TransactionsRepository _transactions;
  final SpendingAnalyzer _spendingAnalyzer;
  final BudgetEngine _budgetEngine;
  final ExpensePredictor _expensePredictor;
  final SmartAlertsEngine _alertsEngine;
  final SmartSearchEngine _searchEngine;
  final VoiceCommandParser _voiceParser;
  final ReceiptParser _receiptParser;
  final CurrencyConverter _currencyConverter;
  final FraudDetector _fraudDetector;
  final CacheStorageService? _cache;

  static const _budgetCacheKey = 'ai_budgets';

  Future<List<Transaction>> _loadTransactions() async {
    final result = await _transactions.getTransactions();
    return result.fold((_) => [], (list) => list);
  }

  void _syncMockContext(
    List<Transaction> txs, {
    double balance = 0,
    String? name,
  }) {
    _orchestrator.mockProvider.updateContext(
      transactions: txs,
      balance: balance,
      userName: name,
    );
  }

  @override
  ResultFuture<AiResponse> chat({
    required String message,
    String locale = 'en',
    String? userName,
    double? balance,
  }) async {
    try {
      final txs = await _loadTransactions();
      _syncMockContext(txs, balance: balance ?? 0, name: userName);
      final response = await _orchestrator.chat(
        userMessage: message,
        locale: locale,
        context: _orchestrator.buildContext(
          userName: userName,
          totalBalance: balance,
          recentTransactions: txs,
        ),
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<AiStreamChunk> chatStream({
    required String message,
    String locale = 'en',
  }) => _orchestrator.chatStream(userMessage: message, locale: locale);

  @override
  ResultFuture<SpendingAnalysis> getSpendingAnalysis() async {
    final txs = await _loadTransactions();
    return Right(_spendingAnalyzer.analyze(txs));
  }

  @override
  ResultFuture<List<BudgetPlan>> getBudgets() async {
    final cached = await _cache?.read(_budgetCacheKey);
    if (cached != null && cached['budgets'] is List) {
      final budgets = (cached['budgets'] as List)
          .cast<Map<String, dynamic>>()
          .map(BudgetPlan.fromJson)
          .toList();
      return Right(budgets);
    }
    final txs = await _loadTransactions();
    final budgets = _budgetEngine.buildDefaultBudgets(txs);
    await _cache?.write(_budgetCacheKey, {
      'budgets': budgets.map((b) => b.toJson()).toList(),
    });
    return Right(budgets);
  }

  @override
  ResultFuture<List<BudgetPlan>> updateBudget(BudgetPlan budget) async {
    final result = await getBudgets();
    return result.fold(Left.new, (budgets) async {
      final updated = budgets
          .map((b) => b.category == budget.category ? budget : b)
          .toList();
      await _cache?.write(_budgetCacheKey, {
        'budgets': updated.map((b) => b.toJson()).toList(),
      });
      return Right(updated);
    });
  }

  @override
  ResultFuture<ExpensePrediction> getExpensePrediction(
    double currentBalance,
  ) async {
    final txs = await _loadTransactions();
    return Right(
      _expensePredictor.predict(
        transactions: txs,
        currentBalance: currentBalance,
      ),
    );
  }

  @override
  ResultFuture<PersonalizedInsights> getPersonalizedInsights(
    double balance,
  ) async {
    final txs = await _loadTransactions();
    final analysis = _spendingAnalyzer.analyze(txs);
    final budgets = _budgetEngine.buildDefaultBudgets(txs);
    final prediction = _expensePredictor.predict(
      transactions: txs,
      currentBalance: balance,
    );
    final savings = _budgetEngine.recommendSavings(budgets);
    final score = _calculateFinanceScore(analysis, budgets);

    return Right(
      PersonalizedInsights(
        monthlySummary: analysis.summary,
        financeScore: score,
        savingSuggestions: savings,
        upcomingBills: prediction.recurringPayments,
        spendingHighlights: analysis.savingsOpportunities,
      ),
    );
  }

  int _calculateFinanceScore(
    SpendingAnalysis analysis,
    List<BudgetPlan> budgets,
  ) {
    var score = 70;
    final overBudget = budgets.where((b) => b.isOverBudget).length;
    score -= overBudget * 10;
    if (analysis.totalSpent < 3000) score += 10;
    if (budgets.every((b) => b.progress < 0.8)) score += 10;
    return score.clamp(0, 100);
  }

  @override
  ResultFuture<List<SmartAlert>> getSmartAlerts(double balance) async {
    final txs = await _loadTransactions();
    final budgets = await getBudgets();
    return budgets.fold(Left.new, (b) {
      return Right(
        _alertsEngine.generate(
          transactions: txs,
          budgets: b,
          currentBalance: balance,
        ),
      );
    });
  }

  @override
  ResultFuture<SmartSearchResult> smartSearch(String query) async {
    final txs = await _loadTransactions();
    return Right(_searchEngine.search(query, txs));
  }

  @override
  ResultFuture<ParsedReceipt> parseReceipt(String rawText) async {
    return Right(_receiptParser.parse(rawText));
  }

  @override
  ResultFuture<VoiceCommand> parseVoiceCommand(
    String text,
    String locale,
  ) async {
    return Right(_voiceParser.parse(text, locale: locale));
  }

  @override
  ResultFuture<List<SupportedCurrency>> getCurrencies() async {
    return Right(await _currencyConverter.fetchLiveRates());
  }

  @override
  ResultFuture<double> convertCurrency({
    required double amount,
    required String from,
    required String to,
  }) async {
    return Right(
      _currencyConverter.convert(amount: amount, fromCode: from, toCode: to),
    );
  }

  @override
  ResultFuture<List<InvestmentHolding>> getInvestmentPortfolio() async {
    return const Right([
      InvestmentHolding(
        id: 'inv_1',
        assetType: InvestmentAssetType.stock,
        symbol: 'AAPL',
        name: 'Apple Inc.',
        quantity: 10,
        currentPrice: 195.50,
        currency: 'USD',
        changePercent24h: 1.2,
      ),
      InvestmentHolding(
        id: 'inv_2',
        assetType: InvestmentAssetType.gold,
        symbol: 'XAU',
        name: 'Gold',
        quantity: 2,
        currentPrice: 2350.0,
        currency: 'USD',
        changePercent24h: 0.4,
      ),
      InvestmentHolding(
        id: 'inv_3',
        assetType: InvestmentAssetType.crypto,
        symbol: 'BTC',
        name: 'Bitcoin',
        quantity: 0.05,
        currentPrice: 67500.0,
        currency: 'USD',
        changePercent24h: -0.8,
      ),
      InvestmentHolding(
        id: 'inv_4',
        assetType: InvestmentAssetType.mutualFund,
        symbol: 'BNKX-GRW',
        name: 'BankX Growth Fund',
        quantity: 100,
        currentPrice: 42.5,
        currency: 'AED',
        changePercent24h: 0.3,
      ),
    ]);
  }

  @override
  ResultFuture<List<FraudSignal>> getFraudSignals() async {
    return Right(_fraudDetector.analyze());
  }

  @override
  ResultFuture<void> clearChatHistory() async {
    await _orchestrator.clearHistory();
    return const Right(null);
  }
}
