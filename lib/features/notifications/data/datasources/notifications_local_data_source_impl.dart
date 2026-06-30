import '../../../../core/storage/cache_storage_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import '../../../../shared/data/mappers/banking_mappers.dart';
import '../../../../shared/domain/entities/notification_model.dart';
import 'notifications_local_data_source.dart';

class NotificationsLocalDataSourceImpl implements NotificationsLocalDataSource {
  NotificationsLocalDataSourceImpl(this._cache);

  final CacheStorageService _cache;

  @override
  Future<List<AppNotification>?> getCachedNotifications() async {
    final items = await _cache.readList(CacheKeys.notifications);
    if (items == null) return null;
    return items
        .map((e) => BankingMappers.toNotification(NotificationDto.fromJson(e)))
        .toList();
  }
}
