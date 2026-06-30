/// Extended secure-storage keys for app security preferences.
abstract final class SecurityStorageKeys {
  static const biometricEnabled = 'biometric_enabled';
  static const pinHash = 'pin_hash';
  static const pinSalt = 'pin_salt';
  static const sessionTimeoutMinutes = 'session_timeout_minutes';
  static const lastActivityMs = 'last_activity_ms';
  static const tokenExpiresAtMs = 'token_expires_at_ms';
}
