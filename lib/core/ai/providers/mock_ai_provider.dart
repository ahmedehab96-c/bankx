import '../../../shared/domain/entities/transaction.dart';
import '../../constants/app_routes.dart';
import '../ai_provider.dart';
import '../engines/budget_engine.dart';
import '../engines/expense_predictor.dart';
import '../engines/spending_analyzer.dart';
import '../models/ai_models.dart';
import '../prompt_manager.dart';

/// On-device AI provider — rule-based NLU with local financial engines.
/// Works offline without API keys. Ideal for demos and fallback.
class MockAiProvider implements AiProvider {
  MockAiProvider({
    SpendingAnalyzer? spendingAnalyzer,
    BudgetEngine? budgetEngine,
    ExpensePredictor? expensePredictor,
    PromptManager? promptManager,
  }) : _spendingAnalyzer = spendingAnalyzer ?? const SpendingAnalyzer(),
       _budgetEngine = budgetEngine ?? const BudgetEngine(),
       _expensePredictor = expensePredictor ?? const ExpensePredictor(),
       _promptManager = promptManager ?? const PromptManager();

  final SpendingAnalyzer _spendingAnalyzer;
  final BudgetEngine _budgetEngine;
  final ExpensePredictor _expensePredictor;
  final PromptManager _promptManager;

  List<Transaction> _transactions = [];
  double _balance = 0;
  String _userName = 'User';

  void updateContext({
    List<Transaction>? transactions,
    double? balance,
    String? userName,
  }) {
    if (transactions != null) _transactions = transactions;
    if (balance != null) _balance = balance;
    if (userName != null) _userName = userName;
  }

  @override
  String get name => 'mock';

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<AiResponse> complete({
    required List<AiMessage> messages,
    int maxTokens = 1024,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final userMsg = messages.lastWhere((m) => m.role == AiMessageRole.user);
    return _respond(userMsg.content, messages);
  }

  @override
  Stream<AiStreamChunk> stream({
    required List<AiMessage> messages,
    int maxTokens = 1024,
  }) async* {
    final response = await complete(messages: messages, maxTokens: maxTokens);
    final words = response.content.split(' ');
    final buffer = StringBuffer();
    for (var i = 0; i < words.length; i++) {
      buffer.write('${words[i]} ');
      yield AiStreamChunk(delta: '${words[i]} ', tokensUsed: 1);
      await Future<void>.delayed(const Duration(milliseconds: 30));
    }
    yield AiStreamChunk(delta: '', isDone: true, tokensUsed: words.length);
  }

  AiResponse _respond(String query, List<AiMessage> messages) {
    final lower = query.toLowerCase();
    final locale = _detectLocale(messages);

    if (_matches(lower, ['balance', 'رصيد', 'how much'])) {
      return AiResponse(
        content: locale.startsWith('ar')
            ? 'رصيدك الإجمالي هو ${_balance.toStringAsFixed(2)} درهم إماراتي.'
            : 'Your total balance is ${_balance.toStringAsFixed(2)} AED.',
        suggestedRoute: AppRoutes.home,
        tokensUsed: 20,
      );
    }

    if (_matches(lower, ['transfer', 'حوالة', 'send money'])) {
      return AiResponse(
        content: locale.startsWith('ar')
            ? 'يمكنك إجراء تحويل من شاشة التحويل. هل تريد فتحها الآن؟'
            : 'You can send money from the Transfer screen. Would you like me to open it?',
        suggestedRoute: AppRoutes.transfer,
        suggestedActions: ['Open Transfer', 'View Beneficiaries'],
        tokensUsed: 25,
      );
    }

    if (_matches(lower, ['spending', 'analyze', 'مصاريف', 'تحليل'])) {
      final analysis = _spendingAnalyzer.analyze(_transactions);
      return AiResponse(
        content:
            '${analysis.summary}\n\n'
            'Savings tips:\n${analysis.savingsOpportunities.map((s) => '• $s').join('\n')}',
        suggestedRoute: AppRoutes.analytics,
        tokensUsed: 80,
      );
    }

    if (_matches(lower, ['budget', 'ميزانية'])) {
      final budgets = _budgetEngine.buildDefaultBudgets(_transactions);
      final warnings = _budgetEngine.predictOverspending(budgets);
      final content = warnings.isEmpty
          ? 'All budgets are on track this month.'
          : 'Budget alerts:\n${warnings.map((w) => '• $w').join('\n')}';
      return AiResponse(
        content: content,
        suggestedRoute: AppRoutes.budget,
        tokensUsed: 60,
      );
    }

    if (_matches(lower, ['predict', 'forecast', 'توقع'])) {
      final prediction = _expensePredictor.predict(
        transactions: _transactions,
        currentBalance: _balance,
      );
      return AiResponse(
        content:
            'End-of-month balance forecast: '
            '${prediction.endOfMonthBalance.toStringAsFixed(0)} AED\n'
            'Expected expenses: ${prediction.expectedExpenses.toStringAsFixed(0)} AED\n'
            'Cash flow: ${prediction.projectedCashFlow.toStringAsFixed(0)} AED',
        suggestedRoute: AppRoutes.analytics,
        tokensUsed: 70,
      );
    }

    if (_matches(lower, ['transaction', 'explain', 'معاملة'])) {
      if (_transactions.isNotEmpty) {
        final t = _transactions.first;
        return AiResponse(
          content: _promptManager
              .transactionExplainPrompt(
                title: t.title,
                amount: t.amount,
                category: t.category,
              )
              .replaceFirst('Explain this transaction: ', ''),
          tokensUsed: 40,
        );
      }
    }

    if (_matches(lower, ['help', 'navigate', 'كيف', 'مساعدة'])) {
      return AiResponse(
        content: locale.startsWith('ar')
            ? 'يمكنني مساعدتك في: التحويلات، المدفوعات، تحليل المصاريف، الميزانية، والبحث في المعاملات.'
            : 'I can help with: transfers, payments, spending analysis, budgets, '
                  'transaction search, and app navigation. Just ask!',
        suggestedActions: [
          'Show balance',
          'Analyze spending',
          'Set budget',
          'Transfer money',
        ],
        tokensUsed: 50,
      );
    }

    return AiResponse(
      content: locale.startsWith('ar')
          ? 'مرحباً $_userName! أنا مساعد BankX الذكي. اسألني عن رصيدك أو مصاريفك أو التحويلات.'
          : 'Hello $_userName! I\'m your BankX AI assistant. '
                'Ask about your balance, spending, budgets, or how to use the app.',
      suggestedActions: [
        'Show my balance',
        'Analyze spending',
        'Help with transfer',
      ],
      tokensUsed: 35,
    );
  }

  String _detectLocale(List<AiMessage> messages) {
    for (final m in messages.reversed) {
      if (m.role == AiMessageRole.user && _containsArabic(m.content)) {
        return 'ar';
      }
    }
    return 'en';
  }

  bool _containsArabic(String text) =>
      RegExp(r'[\u0600-\u06FF]').hasMatch(text);

  bool _matches(String text, List<String> keywords) {
    for (final k in keywords) {
      if (text.contains(k.toLowerCase())) return true;
    }
    return false;
  }
}
