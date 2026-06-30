import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/transactions_usecases.dart';
import 'transactions_event.dart';
import 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc({
    required GetTransactionsUseCase getTransactionsUseCase,
    required GetTransactionByIdUseCase getTransactionByIdUseCase,
  })  : _getTransactionsUseCase = getTransactionsUseCase,
        _getTransactionByIdUseCase = getTransactionByIdUseCase,
        super(const TransactionsState()) {
    on<TransactionsLoaded>(_onTransactionsLoaded);
    on<TransactionDetailsLoaded>(_onTransactionDetailsLoaded);
  }

  final GetTransactionsUseCase _getTransactionsUseCase;
  final GetTransactionByIdUseCase _getTransactionByIdUseCase;

  Future<void> _onTransactionsLoaded(
    TransactionsLoaded event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(listStatus: RequestStatus.loading, clearError: true));
    final result = await _getTransactionsUseCase(
      GetTransactionsParams(type: event.type),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          listStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (transactions) => emit(
        state.copyWith(
          listStatus: RequestStatus.success,
          transactions: transactions,
        ),
      ),
    );
  }

  Future<void> _onTransactionDetailsLoaded(
    TransactionDetailsLoaded event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(detailsStatus: RequestStatus.loading, clearError: true));
    final result = await _getTransactionByIdUseCase(
      GetTransactionByIdParams(event.id),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          detailsStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (transaction) => emit(
        state.copyWith(
          detailsStatus: RequestStatus.success,
          selectedTransaction: transaction,
        ),
      ),
    );
  }
}
