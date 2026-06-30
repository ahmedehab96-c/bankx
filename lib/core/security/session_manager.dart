import 'dart:async';

import '../storage/secure_storage_service.dart';
import 'secure_storage_keys.dart';

typedef SessionExpiredCallback = Future<void> Function();

/// Tracks user activity and triggers auto-logout after inactivity.
class SessionManager {
  SessionManager(this._secureStorage);

  final SecureStorageService _secureStorage;

  static const defaultTimeout = Duration(minutes: 5);

  Timer? _timer;
  Duration _timeout = defaultTimeout;
  SessionExpiredCallback? _onExpired;
  DateTime? _lastPersisted;
  static const _persistDebounce = Duration(seconds: 30);

  Duration get timeout => _timeout;

  Future<void> init({
    SessionExpiredCallback? onExpired,
    Duration? timeout,
  }) async {
    _onExpired = onExpired;
    _timeout = timeout ?? await _loadTimeout();
    await recordActivity();
    _restartTimer();
  }

  Future<void> recordActivity() async {
    final now = DateTime.now();
    if (_lastPersisted != null &&
        now.difference(_lastPersisted!) < _persistDebounce) {
      _restartTimer();
      return;
    }
    _lastPersisted = now;
    await _secureStorage.write(
      SecurityStorageKeys.lastActivityMs,
      now.millisecondsSinceEpoch.toString(),
    );
    _restartTimer();
  }

  Future<void> setTimeout(Duration duration) async {
    _timeout = duration;
    await _secureStorage.write(
      SecurityStorageKeys.sessionTimeoutMinutes,
      duration.inMinutes.toString(),
    );
    _restartTimer();
  }

  Future<void> dispose() async {
    _timer?.cancel();
    _timer = null;
  }

  void _restartTimer() {
    _timer?.cancel();
    _timer = Timer(_timeout, () async {
      await _onExpired?.call();
    });
  }

  Future<Duration> _loadTimeout() async {
    final raw = await _secureStorage.read(
      SecurityStorageKeys.sessionTimeoutMinutes,
    );
    final minutes = int.tryParse(raw ?? '') ?? defaultTimeout.inMinutes;
    return Duration(minutes: minutes.clamp(1, 120));
  }
}
