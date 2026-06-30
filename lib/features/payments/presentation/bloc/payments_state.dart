import 'package:equatable/equatable.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/payments_usecases.dart';

class PaymentsState extends Equatable {
  const PaymentsState({
    this.qrStatus = RequestStatus.initial,
    this.billStatus = RequestStatus.initial,
    this.qrPaymentData,
    this.errorMessage,
    this.successMessage,
  });

  final RequestStatus qrStatus;
  final RequestStatus billStatus;
  final QrPaymentData? qrPaymentData;
  final String? errorMessage;
  final String? successMessage;

  PaymentsState copyWith({
    RequestStatus? qrStatus,
    RequestStatus? billStatus,
    QrPaymentData? qrPaymentData,
    String? errorMessage,
    String? successMessage,
    bool clearMessages = false,
  }) {
    return PaymentsState(
      qrStatus: qrStatus ?? this.qrStatus,
      billStatus: billStatus ?? this.billStatus,
      qrPaymentData: qrPaymentData ?? this.qrPaymentData,
      errorMessage: clearMessages ? null : errorMessage ?? this.errorMessage,
      successMessage: clearMessages
          ? null
          : successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
    qrStatus,
    billStatus,
    qrPaymentData,
    errorMessage,
    successMessage,
  ];
}
