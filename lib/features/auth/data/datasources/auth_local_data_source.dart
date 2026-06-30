import '../../../../shared/data/dto/banking_dtos.dart';

/// Local secure session contract.
abstract class AuthLocalDataSource {
  Future<void> saveSession(AuthResponseDto response);
  Future<void> saveTokens(AuthTokensDto tokens);
  Future<void> clearSession();
  Future<bool> hasSession();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
}
