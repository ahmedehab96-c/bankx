import '../../../../shared/domain/entities/notification_model.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<AppNotification>> fetchNotifications();
  Future<List<AppNotification>> markNotificationRead(int index);
}
