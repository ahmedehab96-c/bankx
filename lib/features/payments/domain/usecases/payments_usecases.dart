import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../shared/domain/entities/user.dart';
import '../repositories/payments_repository.dart';

class QrPaymentData {
  const QrPaymentData({
    required this.user,
    required this.accountName,
    required this.accountNumber,
    required this.iban,
  });

  final UserProfile user;
  final String accountName;
  final String accountNumber;
  final String iban;
}

class GetQrPaymentDataUseCase implements UseCase<QrPaymentData, NoParams> {
  GetQrPaymentDataUseCase(this._repository);

  final PaymentsRepository _repository;

  @override
  ResultFuture<QrPaymentData> call(NoParams params) =>
      _repository.getQrPaymentData();
}

class SubmitBillPaymentParams {
  const SubmitBillPaymentParams({required this.amount, required this.billType});

  final double amount;
  final String billType;
}

class SubmitBillPaymentUseCase
    implements UseCase<void, SubmitBillPaymentParams> {
  SubmitBillPaymentUseCase(this._repository);

  final PaymentsRepository _repository;

  @override
  ResultFuture<void> call(SubmitBillPaymentParams params) => _repository
      .submitBillPayment(amount: params.amount, billType: params.billType);
}
