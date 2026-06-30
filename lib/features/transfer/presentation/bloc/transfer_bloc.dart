import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/transfer_usecases.dart';
import 'transfer_event.dart';
import 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc({
    required GetAccountsUseCase getAccountsUseCase,
    required GetTransferBeneficiariesUseCase getTransferBeneficiariesUseCase,
    required TransferMoneyUseCase transferMoneyUseCase,
    required AddBeneficiaryUseCase addBeneficiaryUseCase,
  })  : _getAccountsUseCase = getAccountsUseCase,
        _getTransferBeneficiariesUseCase = getTransferBeneficiariesUseCase,
        _transferMoneyUseCase = transferMoneyUseCase,
        _addBeneficiaryUseCase = addBeneficiaryUseCase,
        super(const TransferState()) {
    on<TransferLoaded>(_onTransferLoaded);
    on<BeneficiariesLoaded>(_onBeneficiariesLoaded);
    on<TransferSubmitted>(_onTransferSubmitted);
    on<AddBeneficiarySubmitted>(_onAddBeneficiarySubmitted);
  }

  final GetAccountsUseCase _getAccountsUseCase;
  final GetTransferBeneficiariesUseCase _getTransferBeneficiariesUseCase;
  final TransferMoneyUseCase _transferMoneyUseCase;
  final AddBeneficiaryUseCase _addBeneficiaryUseCase;

  Future<void> _onTransferLoaded(
    TransferLoaded event,
    Emitter<TransferState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.loading, clearMessages: true));
    final accountsResult = await _getAccountsUseCase(const NoParams());
    await accountsResult.fold(
      (failure) async => emit(
        state.copyWith(
          loadStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (accounts) async {
        final beneficiariesResult =
            await _getTransferBeneficiariesUseCase(const NoParams());
        beneficiariesResult.fold(
          (failure) => emit(
            state.copyWith(
              loadStatus: RequestStatus.failure,
              errorMessage: failure.message,
            ),
          ),
          (beneficiaries) => emit(
            state.copyWith(
              loadStatus: RequestStatus.success,
              accounts: accounts,
              beneficiaries: beneficiaries,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onBeneficiariesLoaded(
    BeneficiariesLoaded event,
    Emitter<TransferState> emit,
  ) async {
    emit(
      state.copyWith(
        beneficiariesStatus: RequestStatus.loading,
        clearMessages: true,
      ),
    );
    final result = await _getTransferBeneficiariesUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          beneficiariesStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (beneficiaries) => emit(
        state.copyWith(
          beneficiariesStatus: RequestStatus.success,
          beneficiaries: beneficiaries,
        ),
      ),
    );
  }

  Future<void> _onTransferSubmitted(
    TransferSubmitted event,
    Emitter<TransferState> emit,
  ) async {
    emit(state.copyWith(submitStatus: RequestStatus.loading, clearMessages: true));
    final result = await _transferMoneyUseCase(
      TransferMoneyParams(
        fromAccountId: event.fromAccountId,
        beneficiaryId: event.beneficiaryId,
        amount: event.amount,
        note: event.note,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          submitStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          submitStatus: RequestStatus.success,
          successMessage: 'Transfer successful',
        ),
      ),
    );
  }

  Future<void> _onAddBeneficiarySubmitted(
    AddBeneficiarySubmitted event,
    Emitter<TransferState> emit,
  ) async {
    emit(
      state.copyWith(
        addBeneficiaryStatus: RequestStatus.loading,
        clearMessages: true,
      ),
    );
    final addResult = await _addBeneficiaryUseCase(
      AddBeneficiaryParams(
        name: event.name,
        bankName: event.bankName,
        accountNumber: event.accountNumber,
      ),
    );
    await addResult.fold(
      (failure) async => emit(
        state.copyWith(
          addBeneficiaryStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) async {
        final listResult =
            await _getTransferBeneficiariesUseCase(const NoParams());
        listResult.fold(
          (failure) => emit(
            state.copyWith(
              addBeneficiaryStatus: RequestStatus.failure,
              errorMessage: failure.message,
            ),
          ),
          (beneficiaries) => emit(
            state.copyWith(
              addBeneficiaryStatus: RequestStatus.success,
              beneficiaries: beneficiaries,
              successMessage: 'Beneficiary added',
            ),
          ),
        );
      },
    );
  }
}
