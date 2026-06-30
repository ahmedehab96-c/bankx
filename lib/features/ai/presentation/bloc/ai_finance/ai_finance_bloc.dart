import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/ai/engines/budget_engine.dart';
import '../../../../../core/ai/models/ai_models.dart';
import '../../../../../core/utils/usecase.dart';
import '../../../../../shared/bloc/request_status.dart';
import '../../../domain/usecases/ai_usecases.dart';
import 'ai_finance_event.dart';
import 'ai_finance_state.dart';

class AiFinanceBloc extends Bloc<AiFinanceEvent, AiFinanceState> {
  AiFinanceBloc({
    required GetSpendingAnalysisUseCase spendingAnalysisUseCase,
    required GetBudgetsUseCase budgetsUseCase,
    required UpdateBudgetUseCase updateBudgetUseCase,
    required GetExpensePredictionUseCase predictionUseCase,
    required GetPersonalizedInsightsUseCase insightsUseCase,
    required GetSmartAlertsUseCase alertsUseCase,
    BudgetEngine? budgetEngine,
  }) : _spendingAnalysisUseCase = spendingAnalysisUseCase,
       _budgetsUseCase = budgetsUseCase,
       _updateBudgetUseCase = updateBudgetUseCase,
       _predictionUseCase = predictionUseCase,
       _insightsUseCase = insightsUseCase,
       _alertsUseCase = alertsUseCase,
       _budgetEngine = budgetEngine ?? const BudgetEngine(),
       super(const AiFinanceState()) {
    on<AiFinanceLoaded>(_onLoaded);
    on<AiBudgetUpdated>(_onBudgetUpdated);
  }

  final GetSpendingAnalysisUseCase _spendingAnalysisUseCase;
  final GetBudgetsUseCase _budgetsUseCase;
  final UpdateBudgetUseCase _updateBudgetUseCase;
  final GetExpensePredictionUseCase _predictionUseCase;
  final GetPersonalizedInsightsUseCase _insightsUseCase;
  final GetSmartAlertsUseCase _alertsUseCase;
  final BudgetEngine _budgetEngine;

  Future<void> _onLoaded(
    AiFinanceLoaded event,
    Emitter<AiFinanceState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    SpendingAnalysis? analysis;
    List<BudgetPlan> budgets = [];
    ExpensePrediction? prediction;
    PersonalizedInsights? insights;
    List<SmartAlert> alerts = [];

    final analysisResult = await _spendingAnalysisUseCase(const NoParams());
    final budgetsResult = await _budgetsUseCase(const NoParams());
    final predictionResult = await _predictionUseCase(event.balance);
    final insightsResult = await _insightsUseCase(event.balance);
    final alertsResult = await _alertsUseCase(event.balance);

    String? error;

    analysisResult.fold((f) => error = f.message, (a) => analysis = a);
    budgetsResult.fold((f) => error ??= f.message, (b) => budgets = b);
    predictionResult.fold((f) => error ??= f.message, (p) => prediction = p);
    insightsResult.fold((f) => error ??= f.message, (i) => insights = i);
    alertsResult.fold((f) => error ??= f.message, (a) => alerts = a);

    if (error != null) {
      emit(state.copyWith(status: RequestStatus.failure, errorMessage: error));
      return;
    }

    emit(
      state.copyWith(
        status: RequestStatus.success,
        spendingAnalysis: analysis,
        budgets: budgets,
        prediction: prediction,
        insights: insights,
        alerts: alerts,
        overspendingWarnings: _budgetEngine.predictOverspending(budgets),
      ),
    );
  }

  Future<void> _onBudgetUpdated(
    AiBudgetUpdated event,
    Emitter<AiFinanceState> emit,
  ) async {
    final result = await _updateBudgetUseCase(event.budget);
    result.fold(
      (f) => emit(state.copyWith(errorMessage: f.message)),
      (budgets) => emit(
        state.copyWith(
          budgets: budgets,
          overspendingWarnings: _budgetEngine.predictOverspending(budgets),
        ),
      ),
    );
  }
}
