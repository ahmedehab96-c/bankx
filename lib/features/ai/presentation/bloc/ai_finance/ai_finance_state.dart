import 'package:equatable/equatable.dart';

import '../../../../../core/ai/models/ai_models.dart';
import '../../../../../shared/bloc/request_status.dart';

class AiFinanceState extends Equatable {
  const AiFinanceState({
    this.status = RequestStatus.initial,
    this.spendingAnalysis,
    this.budgets = const [],
    this.prediction,
    this.insights,
    this.alerts = const [],
    this.overspendingWarnings = const [],
    this.errorMessage,
  });

  final RequestStatus status;
  final SpendingAnalysis? spendingAnalysis;
  final List<BudgetPlan> budgets;
  final ExpensePrediction? prediction;
  final PersonalizedInsights? insights;
  final List<SmartAlert> alerts;
  final List<String> overspendingWarnings;
  final String? errorMessage;

  AiFinanceState copyWith({
    RequestStatus? status,
    SpendingAnalysis? spendingAnalysis,
    List<BudgetPlan>? budgets,
    ExpensePrediction? prediction,
    PersonalizedInsights? insights,
    List<SmartAlert>? alerts,
    List<String>? overspendingWarnings,
    String? errorMessage,
  }) => AiFinanceState(
    status: status ?? this.status,
    spendingAnalysis: spendingAnalysis ?? this.spendingAnalysis,
    budgets: budgets ?? this.budgets,
    prediction: prediction ?? this.prediction,
    insights: insights ?? this.insights,
    alerts: alerts ?? this.alerts,
    overspendingWarnings: overspendingWarnings ?? this.overspendingWarnings,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    status,
    spendingAnalysis,
    budgets,
    prediction,
    insights,
    alerts,
  ];
}
