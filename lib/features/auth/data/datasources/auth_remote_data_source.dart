import '../../../../shared/data/dto/banking_dtos.dart';

/// Remote authentication API contract.
abstract class AuthRemoteDataSource {
  Future<AuthResponseDto> login({
    required String email,
    required String password,
  });

  Future<AuthResponseDto> register({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthTokensDto> refreshToken(String refreshToken);

  Future<void> logout();

  Future<void> forgotPassword({required String email});

  Future<AuthResponseDto> verifyOtp({required String code});

  Future<void> resetPassword({required String email});
}
