import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/payments_usecases.dart';
import 'payments_event.dart';
import 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  PaymentsBloc({
    required GetQrPaymentDataUseCase getQrPaymentDataUseCase,
    required SubmitBillPaymentUseCase submitBillPaymentUseCase,
  })  : _getQrPaymentDataUseCase = getQrPaymentDataUseCase,
        _submitBillPaymentUseCase = submitBillPaymentUseCase,
        super(const PaymentsState()) {
    on<QrPaymentLoaded>(_onQrPaymentLoaded);
    on<BillPaymentSubmitted>(_onBillPaymentSubmitted);
  }

  final GetQrPaymentDataUseCase _getQrPaymentDataUseCase;
  final SubmitBillPaymentUseCase _submitBillPaymentUseCase;

  Future<void> _onQrPaymentLoaded(
    QrPaymentLoaded event,
    Emitter<PaymentsState> emit,
  ) async {
    emit(state.copyWith(qrStatus: RequestStatus.loading, clearMessages: true));
    final result = await _getQrPaymentDataUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          qrStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (data) => emit(
        state.copyWith(
          qrStatus: RequestStatus.success,
          qrPaymentData: data,
        ),
      ),
    );
  }

  Future<void> _onBillPaymentSubmitted(
    BillPaymentSubmitted event,
    Emitter<PaymentsState> emit,
  ) async {
    emit(state.copyWith(billStatus: RequestStatus.loading, clearMessages: true));
    final result = await _submitBillPaymentUseCase(
      SubmitBillPaymentParams(
        amount: event.amount,
        billType: event.billType,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          billStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          billStatus: RequestStatus.success,
          successMessage: 'Bill paid successfully',
        ),
      ),
    );
  }
}
