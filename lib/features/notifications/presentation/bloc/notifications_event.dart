import 'package:equatable/equatable.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object?> get props => [];
}

class NotificationsLoaded extends NotificationsEvent {
  const NotificationsLoaded();
}

class NotificationMarkedRead extends NotificationsEvent {
  const NotificationMarkedRead(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class AllNotificationsMarkedRead extends NotificationsEvent {
  const AllNotificationsMarkedRead();
}
