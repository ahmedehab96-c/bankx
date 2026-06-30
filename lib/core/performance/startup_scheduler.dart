import 'package:flutter/scheduler.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';
import '../../features/settings/presentation/bloc/settings_event.dart';
import '../di/injection.dart';
import '../firebase/push_notification_service.dart';
import '../offline/offline_sync_service.dart';
import '../security/session_manager.dart';

/// Defers non-critical startup work until after the first frame is painted.
abstract final class StartupScheduler {
  static bool _started = false;

  /// Schedules background services that are not required for the first frame.
  static void scheduleDeferredStartup() {
    if (_started) return;
    _started = true;
    SchedulerBinding.instance.scheduleTask(
      () async => _runDeferredServices(),
      Priority.idle,
    );
  }

  static Future<void> _runDeferredServices() async {
    getIt<SettingsBloc>().add(const SettingsLoaded());
    getIt<OfflineSyncService>().start();
    await getIt<SessionManager>().init(
      onExpired: () async {
        await getIt<AuthRepository>().logout();
      },
    );
  }

  /// Tears down long-lived services when the app root disposes.
  static Future<void> shutdown() async {
    await getIt<OfflineSyncService>().dispose();
    await getIt<SessionManager>().dispose();
    await getIt<PushNotificationService>().dispose();
    _started = false;
  }
}
