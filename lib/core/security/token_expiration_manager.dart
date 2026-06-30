import '../storage/secure_storage_service.dart';
import 'secure_storage_keys.dart';

/// Persists and evaluates JWT access-token expiration timestamps.
class TokenExpirationManager {
  TokenExpirationManager(this._secureStorage);

  final SecureStorageService _secureStorage;

  Future<void> saveExpiration(DateTime expiresAt) => _secureStorage.write(
    SecurityStorageKeys.tokenExpiresAtMs,
    expiresAt.millisecondsSinceEpoch.toString(),
  );

  Future<void> saveExpirationFromTtl(Duration ttl) =>
      saveExpiration(DateTime.now().add(ttl));

  Future<bool> isExpired({Duration grace = const Duration(minutes: 1)}) async {
    final raw = await _secureStorage.read(SecurityStorageKeys.tokenExpiresAtMs);
    if (raw == null) return false;
    final expiresAt = DateTime.fromMillisecondsSinceEpoch(int.parse(raw));
    return DateTime.now().isAfter(expiresAt.subtract(grace));
  }

  Future<void> clear() =>
      _secureStorage.delete(SecurityStorageKeys.tokenExpiresAtMs);
}
