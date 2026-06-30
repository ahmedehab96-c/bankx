import 'package:equatable/equatable.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/notification_model.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.status = RequestStatus.initial,
    this.markReadStatus = RequestStatus.initial,
    this.notifications = const [],
    this.errorMessage,
  });

  final RequestStatus status;
  final RequestStatus markReadStatus;
  final List<AppNotification> notifications;
  final String? errorMessage;

  NotificationsState copyWith({
    RequestStatus? status,
    RequestStatus? markReadStatus,
    List<AppNotification>? notifications,
    String? errorMessage,
    bool clearError = false,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      markReadStatus: markReadStatus ?? this.markReadStatus,
      notifications: notifications ?? this.notifications,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    markReadStatus,
    notifications,
    errorMessage,
  ];
}
