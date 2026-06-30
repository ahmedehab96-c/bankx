import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../shared/domain/entities/notification_model.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationsUseCase
    implements UseCase<List<AppNotification>, NoParams> {
  GetNotificationsUseCase(this._repository);

  final NotificationsRepository _repository;

  @override
  ResultFuture<List<AppNotification>> call(NoParams params) =>
      _repository.getNotifications();
}

class MarkNotificationReadParams {
  const MarkNotificationReadParams(this.index);

  final int index;
}

class MarkNotificationReadUseCase
    implements UseCase<List<AppNotification>, MarkNotificationReadParams> {
  MarkNotificationReadUseCase(this._repository);

  final NotificationsRepository _repository;

  @override
  ResultFuture<List<AppNotification>> call(MarkNotificationReadParams params) =>
      _repository.markNotificationRead(params.index);
}
