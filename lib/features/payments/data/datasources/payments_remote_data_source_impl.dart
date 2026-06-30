import '../../../../core/network/dio_exception_helper.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/api/banking_api_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../domain/usecases/payments_usecases.dart';
import 'payments_remote_data_source.dart';

class PaymentsRemoteDataSourceImpl implements PaymentsRemoteDataSource {
  PaymentsRemoteDataSourceImpl(this._api, this._cache);

  final BankingApiService _api;
  final CacheStorageService _cache;

  @override
  Future<QrPaymentData> fetchQrPaymentData() async {
    try {
      final dto = await _api.getQrPayment();
      await _cache.write(CacheKeys.qrPayment, dto.toJson());
      return BankingMappers.toQrPayment(dto);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<void> submitBillPayment({
    required double amount,
    required String billType,
  }) async {
    try {
      await _api.submitBillPayment(
        BillPaymentRequestDto(amount: amount, billType: billType),
      );
    } catch (e) {
      rethrowAsAppException(e);
    }
  }
}
