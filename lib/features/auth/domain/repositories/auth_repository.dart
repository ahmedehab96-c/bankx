import '../../../../core/utils/result.dart';

/// Domain contract for authentication operations.
abstract class AuthRepository {
  ResultFuture<void> login({required String email, required String password});

  ResultFuture<void> register({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<void> verifyOtp({required String code});

  ResultFuture<void> resetPassword({required String email});

  ResultFuture<void> logout();

  ResultFuture<bool> isAuthenticated();

  ResultFuture<bool> refreshTokens();
}
