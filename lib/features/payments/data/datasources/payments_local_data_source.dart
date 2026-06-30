import '../../domain/usecases/payments_usecases.dart';

abstract class PaymentsLocalDataSource {
  Future<QrPaymentData?> getCachedQrPaymentData();
}
