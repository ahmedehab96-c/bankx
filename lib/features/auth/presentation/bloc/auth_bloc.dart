import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/auth_usecases.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required RegisterUseCase registerUseCase,
    required VerifyOtpUseCase verifyOtpUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _registerUseCase = registerUseCase,
        _verifyOtpUseCase = verifyOtpUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        super(const AuthState()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthOtpVerified>(_onOtpVerified);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthResetPasswordRequested>(_onResetPassword);
    on<AuthMessagesCleared>(
      (event, emit) => emit(state.copyWith(clearMessages: true)),
    );
    on<AuthSessionRestored>(_onSessionRestored);
  }

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegisterUseCase _registerUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearMessages: true));
    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: RequestStatus.success,
          isAuthenticated: true,
          successMessage: 'Login successful',
        ),
      ),
    );
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutUseCase(const NoParams());
    emit(
      const AuthState(
        status: RequestStatus.success,
        isAuthenticated: false,
      ),
    );
  }

  Future<void> _onOtpVerified(
    AuthOtpVerified event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearMessages: true));
    final result = await _verifyOtpUseCase(VerifyOtpParams(code: event.code));
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: RequestStatus.success,
          isAuthenticated: true,
        ),
      ),
    );
  }

  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearMessages: true));
    final result = await _registerUseCase(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: RequestStatus.success,
          successMessage: 'Registration successful',
        ),
      ),
    );
  }

  Future<void> _onResetPassword(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearMessages: true));
    final result = await _resetPasswordUseCase(
      ResetPasswordParams(email: event.email),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: RequestStatus.success,
          successMessage: 'Reset link sent',
        ),
      ),
    );
  }

  void _onSessionRestored(
    AuthSessionRestored event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        status: RequestStatus.success,
        isAuthenticated: true,
      ),
    );
  }
}
