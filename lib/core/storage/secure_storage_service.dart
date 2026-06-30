import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Keys for sensitive credentials — never use SharedPreferences for these.
abstract final class SecureStorageKeys {
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const userId = 'user_id';
  static const userProfile = 'user_profile';
}

/// Wraps [FlutterSecureStorage] for JWT and profile persistence.
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
            );

  final FlutterSecureStorage _storage;

  Future<void> write(String key, String value) => _storage.write(key: key, value: value);

  Future<String?> read(String key) => _storage.read(key: key);

  Future<void> delete(String key) => _storage.delete(key: key);

  Future<void> clearAll() => _storage.deleteAll();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await write(SecureStorageKeys.accessToken, accessToken);
    await write(SecureStorageKeys.refreshToken, refreshToken);
  }

  Future<String?> getAccessToken() => read(SecureStorageKeys.accessToken);

  Future<String?> getRefreshToken() => read(SecureStorageKeys.refreshToken);

  Future<void> saveUserSession({
    required String userId,
    required String profileJson,
  }) async {
    await write(SecureStorageKeys.userId, userId);
    await write(SecureStorageKeys.userProfile, profileJson);
  }

  Future<void> clearSession() => clearAll();
}
