import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../domain/usecases/payments_usecases.dart';
import 'payments_local_data_source.dart';

class PaymentsLocalDataSourceImpl implements PaymentsLocalDataSource {
  PaymentsLocalDataSourceImpl(this._cache);

  final CacheStorageService _cache;

  @override
  Future<QrPaymentData?> getCachedQrPaymentData() async {
    final json = await _cache.read(CacheKeys.qrPayment);
    if (json == null) return null;
    return BankingMappers.toQrPayment(QrPaymentDto.fromJson(json));
  }
}
