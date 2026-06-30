import '../../../../core/network/dio_exception_helper.dart';
import '../../../../shared/data/api/banking_api_service.dart';
import '../../../../shared/data/dto/banking_dtos.dart';
import 'auth_remote_data_source.dart';

/// Production auth remote data source backed by [BankingApiService].
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._api);

  final BankingApiService _api;

  @override
  Future<AuthResponseDto> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _api.login(
        LoginRequestDto(email: email, password: password),
      );
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<AuthResponseDto> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      return await _api.register(
        RegisterRequestDto(name: name, email: email, password: password),
      );
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<AuthTokensDto> refreshToken(String refreshToken) async {
    try {
      return await _api.refreshToken(refreshToken);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _api.logout();
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _api.forgotPassword(email);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<AuthResponseDto> verifyOtp({required String code}) async {
    try {
      return await _api.verifyOtp(code);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _api.forgotPassword(email);
    } catch (e) {
      rethrowAsAppException(e);
    }
  }
}
