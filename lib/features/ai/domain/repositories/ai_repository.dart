import '../../../../core/ai/models/ai_models.dart';
import '../../../../core/utils/result.dart';

/// Unified repository for all AI-powered banking capabilities.
abstract class AiRepository {
  ResultFuture<AiResponse> chat({
    required String message,
    String locale,
    String? userName,
    double? balance,
  });

  Stream<AiStreamChunk> chatStream({required String message, String locale});

  ResultFuture<SpendingAnalysis> getSpendingAnalysis();
  ResultFuture<List<BudgetPlan>> getBudgets();
  ResultFuture<List<BudgetPlan>> updateBudget(BudgetPlan budget);
  ResultFuture<ExpensePrediction> getExpensePrediction(double currentBalance);
  ResultFuture<PersonalizedInsights> getPersonalizedInsights(double balance);
  ResultFuture<List<SmartAlert>> getSmartAlerts(double balance);
  ResultFuture<SmartSearchResult> smartSearch(String query);
  ResultFuture<ParsedReceipt> parseReceipt(String rawText);
  ResultFuture<VoiceCommand> parseVoiceCommand(String text, String locale);
  ResultFuture<List<SupportedCurrency>> getCurrencies();
  ResultFuture<double> convertCurrency({
    required double amount,
    required String from,
    required String to,
  });
  ResultFuture<List<InvestmentHolding>> getInvestmentPortfolio();
  ResultFuture<List<FraudSignal>> getFraudSignals();
  ResultFuture<void> clearChatHistory();
}
