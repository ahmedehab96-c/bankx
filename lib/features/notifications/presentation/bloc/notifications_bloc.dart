import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/notifications_usecases.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({
    required GetNotificationsUseCase getNotificationsUseCase,
    required MarkNotificationReadUseCase markNotificationReadUseCase,
  }) : _getNotificationsUseCase = getNotificationsUseCase,
       _markNotificationReadUseCase = markNotificationReadUseCase,
       super(const NotificationsState()) {
    on<NotificationsLoaded>(_onNotificationsLoaded);
    on<NotificationMarkedRead>(_onNotificationMarkedRead);
    on<AllNotificationsMarkedRead>(_onAllNotificationsMarkedRead);
  }

  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkNotificationReadUseCase _markNotificationReadUseCase;

  Future<void> _onNotificationsLoaded(
    NotificationsLoaded event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearError: true));
    final result = await _getNotificationsUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (notifications) => emit(
        state.copyWith(
          status: RequestStatus.success,
          notifications: notifications,
        ),
      ),
    );
  }

  Future<void> _onNotificationMarkedRead(
    NotificationMarkedRead event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(
      state.copyWith(markReadStatus: RequestStatus.loading, clearError: true),
    );
    final result = await _markNotificationReadUseCase(
      MarkNotificationReadParams(event.index),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          markReadStatus: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (notifications) => emit(
        state.copyWith(
          markReadStatus: RequestStatus.success,
          notifications: notifications,
        ),
      ),
    );
  }

  Future<void> _onAllNotificationsMarkedRead(
    AllNotificationsMarkedRead event,
    Emitter<NotificationsState> emit,
  ) async {
    if (state.notifications.isEmpty) return;
    emit(
      state.copyWith(markReadStatus: RequestStatus.loading, clearError: true),
    );
    var notifications = state.notifications;
    for (var i = 0; i < notifications.length; i++) {
      if (notifications[i].isRead) continue;
      final result = await _markNotificationReadUseCase(
        MarkNotificationReadParams(i),
      );
      final updated = result.fold((_) => null, (list) => list);
      if (updated == null) {
        emit(
          state.copyWith(
            markReadStatus: RequestStatus.failure,
            errorMessage: 'Failed to mark notifications read',
          ),
        );
        return;
      }
      notifications = updated;
    }
    emit(
      state.copyWith(
        markReadStatus: RequestStatus.success,
        notifications: notifications,
      ),
    );
  }
}
