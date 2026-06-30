import '../../../../core/ai/models/ai_models.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/ai_repository.dart';

class ChatParams {
  const ChatParams({
    required this.message,
    this.locale = 'en',
    this.userName,
    this.balance,
  });

  final String message;
  final String locale;
  final String? userName;
  final double? balance;
}

class ChatStreamParams {
  const ChatStreamParams({
    required this.message,
    this.locale = 'en',
    this.userName,
    this.balance,
  });

  final String message;
  final String locale;
  final String? userName;
  final double? balance;
}

class ChatStreamUseCase {
  ChatStreamUseCase(this._repo);
  final AiRepository _repo;

  Stream<AiStreamChunk> call(ChatStreamParams params) => _repo.chatStream(
    message: params.message,
    locale: params.locale,
    userName: params.userName,
    balance: params.balance,
  );
}

class ChatUseCase implements UseCase<AiResponse, ChatParams> {
  ChatUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<AiResponse> call(ChatParams params) => _repo.chat(
    message: params.message,
    locale: params.locale,
    userName: params.userName,
    balance: params.balance,
  );
}

class GetSpendingAnalysisUseCase
    implements UseCase<SpendingAnalysis, NoParams> {
  GetSpendingAnalysisUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<SpendingAnalysis> call(NoParams params) =>
      _repo.getSpendingAnalysis();
}

class GetBudgetsUseCase implements UseCase<List<BudgetPlan>, NoParams> {
  GetBudgetsUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<List<BudgetPlan>> call(NoParams params) => _repo.getBudgets();
}

class UpdateBudgetUseCase implements UseCase<List<BudgetPlan>, BudgetPlan> {
  UpdateBudgetUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<List<BudgetPlan>> call(BudgetPlan params) =>
      _repo.updateBudget(params);
}

class GetExpensePredictionUseCase
    implements UseCase<ExpensePrediction, double> {
  GetExpensePredictionUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<ExpensePrediction> call(double params) =>
      _repo.getExpensePrediction(params);
}

class GetPersonalizedInsightsUseCase
    implements UseCase<PersonalizedInsights, double> {
  GetPersonalizedInsightsUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<PersonalizedInsights> call(double params) =>
      _repo.getPersonalizedInsights(params);
}

class GetSmartAlertsUseCase implements UseCase<List<SmartAlert>, double> {
  GetSmartAlertsUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<List<SmartAlert>> call(double params) =>
      _repo.getSmartAlerts(params);
}

class SmartSearchUseCase implements UseCase<SmartSearchResult, String> {
  SmartSearchUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<SmartSearchResult> call(String params) =>
      _repo.smartSearch(params);
}

class ParseReceiptUseCase implements UseCase<ParsedReceipt, String> {
  ParseReceiptUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<ParsedReceipt> call(String params) => _repo.parseReceipt(params);
}

class ParseReceiptImageUseCase implements UseCase<ParsedReceipt, String> {
  ParseReceiptImageUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<ParsedReceipt> call(String imagePath) =>
      _repo.parseReceiptImage(imagePath);
}

class ParseVoiceCommandUseCase implements UseCase<VoiceCommand, VoiceParams> {
  ParseVoiceCommandUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<VoiceCommand> call(VoiceParams params) =>
      _repo.parseVoiceCommand(params.text, params.locale);
}

class VoiceParams {
  const VoiceParams({required this.text, this.locale = 'en'});
  final String text;
  final String locale;
}

class GetCurrenciesUseCase
    implements UseCase<List<SupportedCurrency>, NoParams> {
  GetCurrenciesUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<List<SupportedCurrency>> call(NoParams params) =>
      _repo.getCurrencies();
}

class ConvertCurrencyParams {
  const ConvertCurrencyParams({
    required this.amount,
    required this.from,
    required this.to,
  });

  final double amount;
  final String from;
  final String to;
}

class ConvertCurrencyUseCase implements UseCase<double, ConvertCurrencyParams> {
  ConvertCurrencyUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<double> call(ConvertCurrencyParams params) => _repo
      .convertCurrency(amount: params.amount, from: params.from, to: params.to);
}

class GetInvestmentsUseCase
    implements UseCase<List<InvestmentHolding>, NoParams> {
  GetInvestmentsUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<List<InvestmentHolding>> call(NoParams params) =>
      _repo.getInvestmentPortfolio();
}

class ClearChatHistoryUseCase implements UseCase<void, NoParams> {
  ClearChatHistoryUseCase(this._repo);
  final AiRepository _repo;

  @override
  ResultFuture<void> call(NoParams params) => _repo.clearChatHistory();
}
