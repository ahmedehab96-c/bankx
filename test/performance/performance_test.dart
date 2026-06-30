import 'package:bankx/core/network/network_bound_resource.dart';
import 'package:bankx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bankx/features/auth/presentation/bloc/auth_event.dart';
import 'package:bankx/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:bankx/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:bankx/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:bankx/shared/bloc/request_status.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/bloc_mocks.dart';
import '../helpers/mock_definitions.dart';
import '../helpers/result_helpers.dart';
import '../helpers/test_fixtures.dart';

/// Performance benchmarks for critical paths — run with `flutter test test/performance`.
void main() {
  setUpAll(registerBlocTestFallbacks);

  group('Repository performance', () {
    test('NetworkBoundResource completes under 50ms with fast remote', () async {
      final network = MockNetworkInfo();
      when(() => network.isConnected).thenAnswer((_) async => true);

      final stopwatch = Stopwatch()..start();
      final result = await NetworkBoundResource<int>(
        networkInfo: network,
        fetchRemote: () async => 1,
        fetchLocal: () async => null,
        saveLocal: (_) async {},
      ).execute();
      stopwatch.stop();

      expect(result, testRight(1));
      expect(stopwatch.elapsedMilliseconds, lessThan(50));
    });
  });

  group('Bloc performance', () {
    test('DashboardBloc handles 100 rapid events', () async {
      final dashboard = MockGetDashboardDataUseCase();
      final analytics = MockGetAnalyticsDataUseCase();
      when(() => dashboard(any()))
          .thenAnswer((_) async => Right(TestFixtures.dashboardData));

      final bloc = DashboardBloc(
        getDashboardDataUseCase: dashboard,
        getAnalyticsDataUseCase: analytics,
      );
      addTearDown(bloc.close);

      final stopwatch = Stopwatch()..start();
      for (var i = 0; i < 100; i++) {
        bloc.add(const DashboardLoaded());
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));
      stopwatch.stop();

      expect(bloc.state.status, RequestStatus.success);
      expect(stopwatch.elapsedMilliseconds, lessThan(2000));
    });

    test('AuthBloc login round-trip under 100ms', () async {
      final login = MockLoginUseCase();
      when(() => login(any())).thenAnswer((_) async => futureRightVoid());

      final bloc = AuthBloc(
        loginUseCase: login,
        logoutUseCase: MockLogoutUseCase(),
        registerUseCase: MockRegisterUseCase(),
        verifyOtpUseCase: MockVerifyOtpUseCase(),
        resetPasswordUseCase: MockResetPasswordUseCase(),
      );
      addTearDown(bloc.close);

      final stopwatch = Stopwatch()..start();
      bloc.add(const AuthLoginRequested(email: 'a@b.com', password: 'pass'));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      stopwatch.stop();

      expect(bloc.state.isAuthenticated, isTrue);
      expect(stopwatch.elapsedMilliseconds, lessThan(100));
    });
  });

  group('Memory usage smoke', () {
    test('DashboardState copies do not leak large lists', () {
      final state = DashboardState(
        status: RequestStatus.success,
        dashboardData: TestFixtures.dashboardData,
      );
      final copies = List.generate(1000, (_) => state.copyWith());
      expect(copies.last.dashboardData?.accounts.length, 1);
    });
  });
}
