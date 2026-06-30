import '../../../../core/utils/result.dart';
import '../usecases/payments_usecases.dart';

abstract class PaymentsRepository {
  ResultFuture<QrPaymentData> getQrPaymentData();
  ResultFuture<void> submitBillPayment({
    required double amount,
    required String billType,
  });
}
