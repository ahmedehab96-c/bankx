import 'dart:convert';

import '../../../../core/storage/secure_storage_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import 'auth_local_data_source.dart';

/// Secure session store — tokens and profile never touch SharedPreferences.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._secureStorage);

  final SecureStorageService _secureStorage;

  @override
  Future<void> saveSession(AuthResponseDto response) async {
    await _secureStorage.saveTokens(
      accessToken: response.tokens.accessToken,
      refreshToken: response.tokens.refreshToken,
    );
    await _secureStorage.saveUserSession(
      userId: response.user.id,
      profileJson: jsonEncode(response.user.toJson()),
    );
  }

  @override
  Future<void> saveTokens(AuthTokensDto tokens) async {
    await _secureStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }

  @override
  Future<void> clearSession() => _secureStorage.clearSession();

  @override
  Future<bool> hasSession() async {
    final token = await _secureStorage.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getAccessToken() => _secureStorage.getAccessToken();

  @override
  Future<String?> getRefreshToken() => _secureStorage.getRefreshToken();
}
