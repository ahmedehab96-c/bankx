import '../../../../core/utils/result.dart';
import '../../../../shared/domain/entities/notification_model.dart';

abstract class NotificationsRepository {
  ResultFuture<List<AppNotification>> getNotifications();
  ResultFuture<List<AppNotification>> markNotificationRead(int index);
}
