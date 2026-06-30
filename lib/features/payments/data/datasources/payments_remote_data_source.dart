import '../../domain/usecases/payments_usecases.dart';

abstract class PaymentsRemoteDataSource {
  Future<QrPaymentData> fetchQrPaymentData();
  Future<void> submitBillPayment({
    required double amount,
    required String billType,
  });
}
