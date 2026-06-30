import 'package:equatable/equatable.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/transaction.dart';

class TransactionsState extends Equatable {
  const TransactionsState({
    this.listStatus = RequestStatus.initial,
    this.detailsStatus = RequestStatus.initial,
    this.transactions = const [],
    this.selectedTransaction,
    this.errorMessage,
  });

  final RequestStatus listStatus;
  final RequestStatus detailsStatus;
  final List<Transaction> transactions;
  final Transaction? selectedTransaction;
  final String? errorMessage;

  TransactionsState copyWith({
    RequestStatus? listStatus,
    RequestStatus? detailsStatus,
    List<Transaction>? transactions,
    Transaction? selectedTransaction,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TransactionsState(
      listStatus: listStatus ?? this.listStatus,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      transactions: transactions ?? this.transactions,
      selectedTransaction: selectedTransaction ?? this.selectedTransaction,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [listStatus, detailsStatus, transactions, selectedTransaction, errorMessage];
}
