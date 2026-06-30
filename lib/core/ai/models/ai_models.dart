import 'package:equatable/equatable.dart';

/// Role of a message in an AI conversation.
enum AiMessageRole { user, assistant, system }

/// Single message in a conversation thread.
class AiMessage extends Equatable {
  const AiMessage({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
    this.metadata,
  });

  final String id;
  final AiMessageRole role;
  final String content;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  Map<String, dynamic> toJson() => {
    'id': id,
    'role': role.name,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
    if (metadata != null) 'metadata': metadata,
  };

  factory AiMessage.fromJson(Map<String, dynamic> json) => AiMessage(
    id: json['id'] as String,
    role: AiMessageRole.values.byName(json['role'] as String),
    content: json['content'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
    metadata: json['metadata'] as Map<String, dynamic>?,
  );

  @override
  List<Object?> get props => [id, role, content, timestamp];
}

/// Streaming chunk from an AI provider.
class AiStreamChunk extends Equatable {
  const AiStreamChunk({
    required this.delta,
    this.isDone = false,
    this.tokensUsed,
  });

  final String delta;
  final bool isDone;
  final int? tokensUsed;

  @override
  List<Object?> get props => [delta, isDone, tokensUsed];
}

/// Complete AI response with optional navigation hint.
class AiResponse extends Equatable {
  const AiResponse({
    required this.content,
    this.suggestedRoute,
    this.suggestedActions = const [],
    this.tokensUsed = 0,
    this.fromCache = false,
  });

  final String content;
  final String? suggestedRoute;
  final List<String> suggestedActions;
  final int tokensUsed;
  final bool fromCache;

  @override
  List<Object?> get props => [
    content,
    suggestedRoute,
    suggestedActions,
    tokensUsed,
    fromCache,
  ];
}

/// Spending category breakdown.
class SpendingCategory extends Equatable {
  const SpendingCategory({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.color,
    this.icon,
  });

  final String name;
  final double amount;
  final double percentage;
  final int color;
  final String? icon;

  @override
  List<Object?> get props => [name, amount, percentage];
}

/// Monthly spending trend point.
class SpendingTrend extends Equatable {
  const SpendingTrend({
    required this.label,
    required this.amount,
    required this.changePercent,
  });

  final String label;
  final double amount;
  final double changePercent;

  @override
  List<Object?> get props => [label, amount, changePercent];
}

/// AI-generated spending analysis.
class SpendingAnalysis extends Equatable {
  const SpendingAnalysis({
    required this.categories,
    required this.trends,
    required this.largestExpense,
    required this.totalSpent,
    required this.savingsOpportunities,
    required this.summary,
  });

  final List<SpendingCategory> categories;
  final List<SpendingTrend> trends;
  final String largestExpense;
  final double totalSpent;
  final List<String> savingsOpportunities;
  final String summary;

  @override
  List<Object?> get props => [
    categories,
    trends,
    largestExpense,
    totalSpent,
    summary,
  ];
}

/// User-defined monthly budget.
class BudgetPlan extends Equatable {
  const BudgetPlan({
    required this.category,
    required this.monthlyLimit,
    required this.spent,
    required this.currency,
  });

  final String category;
  final double monthlyLimit;
  final double spent;
  final String currency;

  double get remaining => monthlyLimit - spent;
  double get progress => monthlyLimit > 0 ? spent / monthlyLimit : 0;
  bool get isOverBudget => spent > monthlyLimit;

  BudgetPlan copyWith({double? monthlyLimit, double? spent}) => BudgetPlan(
    category: category,
    monthlyLimit: monthlyLimit ?? this.monthlyLimit,
    spent: spent ?? this.spent,
    currency: currency,
  );

  Map<String, dynamic> toJson() => {
    'category': category,
    'monthly_limit': monthlyLimit,
    'spent': spent,
    'currency': currency,
  };

  factory BudgetPlan.fromJson(Map<String, dynamic> json) => BudgetPlan(
    category: json['category'] as String,
    monthlyLimit: (json['monthly_limit'] as num).toDouble(),
    spent: (json['spent'] as num).toDouble(),
    currency: json['currency'] as String? ?? 'AED',
  );

  @override
  List<Object?> get props => [category, monthlyLimit, spent, currency];
}

/// Expense and cash-flow predictions.
class ExpensePrediction extends Equatable {
  const ExpensePrediction({
    required this.endOfMonthBalance,
    required this.expectedExpenses,
    required this.projectedCashFlow,
    required this.recurringPayments,
    required this.confidence,
  });

  final double endOfMonthBalance;
  final double expectedExpenses;
  final double projectedCashFlow;
  final List<RecurringPayment> recurringPayments;
  final double confidence;

  @override
  List<Object?> get props => [
    endOfMonthBalance,
    expectedExpenses,
    projectedCashFlow,
    confidence,
  ];
}

class RecurringPayment extends Equatable {
  const RecurringPayment({
    required this.name,
    required this.amount,
    required this.dueDate,
    required this.category,
  });

  final String name;
  final double amount;
  final DateTime dueDate;
  final String category;

  @override
  List<Object?> get props => [name, amount, dueDate];
}

/// Intelligent alert generated by AI engines.
class SmartAlert extends Equatable {
  const SmartAlert({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.severity,
    required this.createdAt,
    this.actionRoute,
  });

  final String id;
  final SmartAlertType type;
  final String title;
  final String body;
  final AlertSeverity severity;
  final DateTime createdAt;
  final String? actionRoute;

  @override
  List<Object?> get props => [id, type, title, severity];
}

enum SmartAlertType {
  unusualSpending,
  largeTransaction,
  budgetExceeded,
  salaryReceived,
  upcomingBill,
  suspiciousActivity,
  fraudWarning,
}

enum AlertSeverity { info, warning, critical }

/// Parsed receipt from OCR.
class ParsedReceipt extends Equatable {
  const ParsedReceipt({
    required this.merchantName,
    required this.amount,
    required this.date,
    required this.category,
    required this.rawText,
    required this.confidence,
  });

  final String merchantName;
  final double amount;
  final DateTime date;
  final String category;
  final String rawText;
  final double confidence;

  @override
  List<Object?> get props => [merchantName, amount, date, category];
}

/// Voice command parse result.
class VoiceCommand extends Equatable {
  const VoiceCommand({
    required this.intent,
    required this.rawText,
    required this.locale,
    this.parameters = const {},
    this.route,
  });

  final String intent;
  final String rawText;
  final String locale;
  final Map<String, String> parameters;
  final String? route;

  @override
  List<Object?> get props => [intent, rawText, locale, route];
}

/// Smart search query result.
class SmartSearchResult extends Equatable {
  const SmartSearchResult({
    required this.transactionIds,
    required this.interpretation,
    required this.totalAmount,
  });

  final List<String> transactionIds;
  final String interpretation;
  final double totalAmount;

  @override
  List<Object?> get props => [transactionIds, interpretation, totalAmount];
}

/// Fraud detection signal.
class FraudSignal extends Equatable {
  const FraudSignal({
    required this.type,
    required this.description,
    required this.riskScore,
    required this.detectedAt,
  });

  final FraudSignalType type;
  final String description;
  final double riskScore;
  final DateTime detectedAt;

  @override
  List<Object?> get props => [type, description, riskScore];
}

enum FraudSignalType {
  repeatedFailedLogin,
  abnormalLocation,
  rapidTransfers,
  largeUnusualPayment,
}

/// Supported fiat currency.
class SupportedCurrency extends Equatable {
  const SupportedCurrency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.rateToAed,
  });

  final String code;
  final String name;
  final String symbol;
  final double rateToAed;

  @override
  List<Object?> get props => [code, rateToAed];
}

/// Investment portfolio item (architecture placeholder).
class InvestmentHolding extends Equatable {
  const InvestmentHolding({
    required this.id,
    required this.assetType,
    required this.symbol,
    required this.name,
    required this.quantity,
    required this.currentPrice,
    required this.currency,
    required this.changePercent24h,
  });

  final String id;
  final InvestmentAssetType assetType;
  final String symbol;
  final String name;
  final double quantity;
  final double currentPrice;
  final String currency;
  final double changePercent24h;

  double get totalValue => quantity * currentPrice;

  @override
  List<Object?> get props => [id, symbol, assetType, totalValue];
}

enum InvestmentAssetType { stock, gold, crypto, mutualFund }

/// Personalized dashboard insights bundle.
class PersonalizedInsights extends Equatable {
  const PersonalizedInsights({
    required this.monthlySummary,
    required this.financeScore,
    required this.savingSuggestions,
    required this.upcomingBills,
    required this.spendingHighlights,
  });

  final String monthlySummary;
  final int financeScore;
  final List<String> savingSuggestions;
  final List<RecurringPayment> upcomingBills;
  final List<String> spendingHighlights;

  @override
  List<Object?> get props => [monthlySummary, financeScore, savingSuggestions];
}
