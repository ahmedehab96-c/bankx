import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/accounts_usecases.dart';
import 'accounts_event.dart';
import 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc({required GetAccountByIdUseCase getAccountByIdUseCase})
      : _getAccountByIdUseCase = getAccountByIdUseCase,
        super(const AccountsState()) {
    on<AccountDetailsLoaded>(_onAccountDetailsLoaded);
  }

  final GetAccountByIdUseCase _getAccountByIdUseCase;

  Future<void> _onAccountDetailsLoaded(
    AccountDetailsLoaded event,
    Emitter<AccountsState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearError: true));
    final result = await _getAccountByIdUseCase(
      GetAccountByIdParams(event.id),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (account) => emit(
        state.copyWith(
          status: RequestStatus.success,
          account: account,
        ),
      ),
    );
  }
}
