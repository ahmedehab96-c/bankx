import 'package:equatable/equatable.dart';

import '../../../../../core/ai/models/ai_models.dart';

abstract class AiFinanceEvent extends Equatable {
  const AiFinanceEvent();

  @override
  List<Object?> get props => [];
}

class AiFinanceLoaded extends AiFinanceEvent {
  const AiFinanceLoaded({required this.balance});
  final double balance;

  @override
  List<Object?> get props => [balance];
}

class AiBudgetUpdated extends AiFinanceEvent {
  const AiBudgetUpdated(this.budget);
  final BudgetPlan budget;

  @override
  List<Object?> get props => [budget];
}
