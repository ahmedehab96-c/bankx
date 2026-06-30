import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;
}

class LoginUseCase implements UseCase<void, LoginParams> {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(LoginParams params) =>
      _repository.login(email: params.email, password: params.password);
}

class LogoutUseCase implements UseCase<void, NoParams> {
  LogoutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(NoParams params) => _repository.logout();
}

class RegisterParams {
  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;
}

class RegisterUseCase implements UseCase<void, RegisterParams> {
  RegisterUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(RegisterParams params) => _repository.register(
    name: params.name,
    email: params.email,
    password: params.password,
  );
}

class VerifyOtpParams {
  const VerifyOtpParams({required this.code});

  final String code;
}

class VerifyOtpUseCase implements UseCase<void, VerifyOtpParams> {
  VerifyOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(VerifyOtpParams params) =>
      _repository.verifyOtp(code: params.code);
}

class ResetPasswordParams {
  const ResetPasswordParams({required this.email});

  final String email;
}

class ResetPasswordUseCase implements UseCase<void, ResetPasswordParams> {
  ResetPasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(ResetPasswordParams params) =>
      _repository.resetPassword(email: params.email);
}

class CheckAuthUseCase implements UseCase<bool, NoParams> {
  CheckAuthUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<bool> call(NoParams params) => _repository.isAuthenticated();
}
