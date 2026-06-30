import '../../../../shared/domain/entities/notification_model.dart';

abstract class NotificationsLocalDataSource {
  Future<List<AppNotification>?> getCachedNotifications();
}
