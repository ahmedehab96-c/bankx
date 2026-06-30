import '../../../../core/network/dio_exception_helper.dart';
import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/api/banking_api_service.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../../../shared/domain/entities/notification_model.dart';
import 'notifications_remote_data_source.dart';

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  NotificationsRemoteDataSourceImpl(this._api, this._cache);

  final BankingApiService _api;
  final CacheStorageService _cache;

  @override
  Future<List<AppNotification>> fetchNotifications() async {
    try {
      final dtos = await _api.getNotifications();
      await _cache.writeList(
        CacheKeys.notifications,
        dtos.map((e) => e.toJson()).toList(),
      );
      return dtos.map(BankingMappers.toNotification).toList();
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<List<AppNotification>> markNotificationRead(int index) async {
    try {
      await _api.markNotificationRead(index);
      return fetchNotifications();
    } catch (e) {
      rethrowAsAppException(e);
    }
  }
}
