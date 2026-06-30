import 'package:equatable/equatable.dart';

import '../../../../shared/domain/entities/transaction.dart';

abstract class TransactionsEvent extends Equatable {
  const TransactionsEvent();

  @override
  List<Object?> get props => [];
}

class TransactionsLoaded extends TransactionsEvent {
  const TransactionsLoaded({this.type});

  final TransactionType? type;

  @override
  List<Object?> get props => [type];
}

class TransactionDetailsLoaded extends TransactionsEvent {
  const TransactionDetailsLoaded(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
