import 'package:bankx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bankx/features/auth/presentation/bloc/auth_event.dart';
import 'package:bankx/features/auth/presentation/bloc/auth_state.dart';
import 'package:bankx/shared/bloc/request_status.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/bloc_mocks.dart';
import '../helpers/result_helpers.dart';

void main() {
  setUpAll(registerBlocTestFallbacks);

  late MockLoginUseCase loginUseCase;
  late MockLogoutUseCase logoutUseCase;
  late MockRegisterUseCase registerUseCase;
  late MockVerifyOtpUseCase verifyOtpUseCase;
  late MockResetPasswordUseCase resetPasswordUseCase;

  AuthBloc buildBloc() => AuthBloc(
        loginUseCase: loginUseCase,
        logoutUseCase: logoutUseCase,
        registerUseCase: registerUseCase,
        verifyOtpUseCase: verifyOtpUseCase,
        resetPasswordUseCase: resetPasswordUseCase,
      );

  setUp(() {
    loginUseCase = MockLoginUseCase();
    logoutUseCase = MockLogoutUseCase();
    registerUseCase = MockRegisterUseCase();
    verifyOtpUseCase = MockVerifyOtpUseCase();
    resetPasswordUseCase = MockResetPasswordUseCase();
  });

  test('initial state is unauthenticated', () {
    expect(buildBloc().state, const AuthState());
  });

  blocTest<AuthBloc, AuthState>(
    'emits loading then success on login',
    build: () {
      when(() => loginUseCase(any())).thenAnswer((_) async => futureRightVoid());
      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const AuthLoginRequested(email: 'a@b.com', password: 'pass'),
    ),
    expect: () => [
      isA<AuthState>().having((s) => s.status, 'status', RequestStatus.loading),
      isA<AuthState>()
          .having((s) => s.status, 'status', RequestStatus.success)
          .having((s) => s.isAuthenticated, 'auth', true),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits failure on unauthorized login',
    build: () {
      when(() => loginUseCase(any()))
          .thenAnswer((_) async => futureLeft(FailureFixtures.unauthorized));
      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const AuthLoginRequested(email: 'a@b.com', password: 'wrong'),
    ),
    expect: () => [
      isA<AuthState>().having((s) => s.status, 'status', RequestStatus.loading),
      isA<AuthState>()
          .having((s) => s.status, 'status', RequestStatus.failure)
          .having((s) => s.errorMessage, 'error', FailureFixtures.unauthorized.message),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits failure on network error',
    build: () {
      when(() => loginUseCase(any()))
          .thenAnswer((_) async => futureLeft(FailureFixtures.network));
      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const AuthLoginRequested(email: 'a@b.com', password: 'pass'),
    ),
    expect: () => [
      isA<AuthState>().having((s) => s.status, 'status', RequestStatus.loading),
      isA<AuthState>().having((s) => s.errorMessage, 'error', FailureFixtures.network.message),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'emits failure on timeout',
    build: () {
      when(() => loginUseCase(any()))
          .thenAnswer((_) async => futureLeft(FailureFixtures.timeout));
      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const AuthLoginRequested(email: 'a@b.com', password: 'pass'),
    ),
    expect: () => [
      isA<AuthState>().having((s) => s.status, 'status', RequestStatus.loading),
      isA<AuthState>().having((s) => s.errorMessage, 'error', FailureFixtures.timeout.message),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'logout clears authentication',
    build: () {
      when(() => logoutUseCase(any())).thenAnswer((_) async => futureRightVoid());
      return buildBloc();
    },
    act: (bloc) => bloc.add(const AuthLogoutRequested()),
    expect: () => [
      isA<AuthState>()
          .having((s) => s.isAuthenticated, 'auth', false)
          .having((s) => s.status, 'status', RequestStatus.success),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'OTP verification authenticates user',
    build: () {
      when(() => verifyOtpUseCase(any())).thenAnswer((_) async => futureRightVoid());
      return buildBloc();
    },
    act: (bloc) => bloc.add(const AuthOtpVerified('123456')),
    expect: () => [
      isA<AuthState>().having((s) => s.status, 'status', RequestStatus.loading),
      isA<AuthState>()
          .having((s) => s.isAuthenticated, 'auth', true)
          .having((s) => s.status, 'status', RequestStatus.success),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'session restored marks user authenticated',
    build: buildBloc,
    act: (bloc) => bloc.add(const AuthSessionRestored()),
    expect: () => [
      isA<AuthState>()
          .having((s) => s.isAuthenticated, 'auth', true)
          .having((s) => s.status, 'status', RequestStatus.success),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'register emits success message',
    build: () {
      when(() => registerUseCase(any())).thenAnswer((_) async => futureRightVoid());
      return buildBloc();
    },
    act: (bloc) => bloc.add(
      const AuthRegisterRequested(
        name: 'Ahmed',
        email: 'a@b.com',
        password: 'pass',
      ),
    ),
    expect: () => [
      isA<AuthState>().having((s) => s.status, 'status', RequestStatus.loading),
      isA<AuthState>()
          .having((s) => s.status, 'status', RequestStatus.success)
          .having((s) => s.successMessage, 'msg', 'Registration successful'),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'reset password emits failure on validation error',
    build: () {
      when(() => resetPasswordUseCase(any()))
          .thenAnswer((_) async => futureLeft(FailureFixtures.validation));
      return buildBloc();
    },
    act: (bloc) => bloc.add(const AuthResetPasswordRequested('bad-email')),
    expect: () => [
      isA<AuthState>().having((s) => s.status, 'status', RequestStatus.loading),
      isA<AuthState>().having((s) => s.errorMessage, 'error', FailureFixtures.validation.message),
    ],
  );
}
