import 'package:bankx/core/errors/failures.dart';
import 'package:bankx/core/utils/usecase.dart';
import 'package:bankx/features/accounts/domain/usecases/accounts_usecases.dart';
import 'package:bankx/features/auth/domain/usecases/auth_usecases.dart';
import 'package:bankx/features/cards/domain/usecases/cards_usecases.dart';
import 'package:bankx/features/dashboard/domain/usecases/dashboard_usecases.dart';
import 'package:bankx/features/notifications/domain/usecases/notifications_usecases.dart';
import 'package:bankx/features/payments/domain/usecases/payments_usecases.dart';
import 'package:bankx/features/profile/domain/usecases/profile_usecases.dart';
import 'package:bankx/features/settings/domain/usecases/settings_usecases.dart';
import 'package:bankx/features/transactions/domain/usecases/transactions_usecases.dart';
import 'package:bankx/features/transfer/domain/usecases/transfer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_definitions.dart';
import '../../helpers/result_helpers.dart';
import '../../helpers/test_fixtures.dart';

void main() {
  setUp(registerFallbackValues);

  group('Auth use cases', () {
    late MockAuthRepository repository;

    setUp(() => repository = MockAuthRepository());

    test('LoginUseCase delegates to repository', () async {
      when(
        () => repository.login(email: 'a@b.com', password: 'pass'),
      ).thenAnswer((_) async => futureRightVoid());

      final useCase = LoginUseCase(repository);
      final result = await useCase(
        const LoginParams(email: 'a@b.com', password: 'pass'),
      );
      expect(result, testRightVoid);
    });

    test('LogoutUseCase delegates to repository', () async {
      when(
        () => repository.logout(),
      ).thenAnswer((_) async => futureRightVoid());
      final result = await LogoutUseCase(repository)(const NoParams());
      expect(result, testRightVoid);
    });

    test('RegisterUseCase propagates failure', () async {
      when(
        () => repository.register(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => futureLeft(const ServerFailure()));

      final result = await RegisterUseCase(repository)(
        const RegisterParams(name: 'A', email: 'a@b.com', password: 'p'),
      );
      expect(result, testLeft<void>(const ServerFailure()));
    });
  });

  group('Dashboard use cases', () {
    late MockDashboardRepository repository;

    setUp(() => repository = MockDashboardRepository());

    test('GetDashboardDataUseCase returns dashboard', () async {
      when(
        () => repository.getDashboardData(),
      ).thenAnswer((_) async => Right(TestFixtures.dashboardData));

      final result = await GetDashboardDataUseCase(repository)(
        const NoParams(),
      );
      expect(result.isRight(), isTrue);
    });

    test('GetAnalyticsDataUseCase returns analytics', () async {
      when(
        () => repository.getAnalyticsData(),
      ).thenAnswer((_) async => Right(TestFixtures.analyticsData));

      final result = await GetAnalyticsDataUseCase(repository)(
        const NoParams(),
      );
      expect(result.isRight(), isTrue);
    });
  });

  group('Accounts use cases', () {
    test('GetAccountByIdUseCase delegates id', () async {
      final repository = MockAccountsRepository();
      when(
        () => repository.getAccountById('acc-1'),
      ).thenAnswer((_) async => const Right(TestFixtures.account));

      final result = await GetAccountByIdUseCase(repository)(
        const GetAccountByIdParams('acc-1'),
      );
      expect(result.isRight(), isTrue);
    });
  });

  group('Transactions use cases', () {
    test('GetTransactionsUseCase passes type filter', () async {
      final repository = MockTransactionsRepository();
      when(
        () => repository.getTransactions(type: any(named: 'type')),
      ).thenAnswer((_) async => Right([TestFixtures.transaction]));

      final result = await GetTransactionsUseCase(repository)(
        const GetTransactionsParams(),
      );
      expect(result.fold((l) => 0, (r) => r.length), 1);
    });
  });

  group('Transfer use cases', () {
    test('TransferMoneyUseCase delegates transfer', () async {
      final repository = MockTransferRepository();
      when(
        () => repository.transfer(
          fromAccountId: 'a1',
          beneficiaryId: 'b1',
          amount: 100,
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async => futureRightVoid());

      final result = await TransferMoneyUseCase(repository)(
        const TransferMoneyParams(
          fromAccountId: 'a1',
          beneficiaryId: 'b1',
          amount: 100,
        ),
      );
      expect(result, testRightVoid);
    });
  });

  group('Cards use cases', () {
    test('ToggleCardFreezeUseCase delegates freeze', () async {
      final repository = MockCardsRepository();
      when(
        () => repository.toggleCardFreeze('card-1'),
      ).thenAnswer((_) async => const Right(TestFixtures.card));

      final result = await ToggleCardFreezeUseCase(repository)(
        const ToggleCardFreezeParams('card-1'),
      );
      expect(result.isRight(), isTrue);
    });
  });

  group('Payments use cases', () {
    test('GetQrPaymentDataUseCase returns QR data', () async {
      final repository = MockPaymentsRepository();
      when(
        () => repository.getQrPaymentData(),
      ).thenAnswer((_) async => Right(TestFixtures.qrPaymentData));

      final result = await GetQrPaymentDataUseCase(repository)(
        const NoParams(),
      );
      expect(result.isRight(), isTrue);
    });

    test('SubmitBillPaymentUseCase returns network failure', () async {
      final repository = MockPaymentsRepository();
      when(
        () => repository.submitBillPayment(amount: 50, billType: 'water'),
      ).thenAnswer((_) async => futureLeft(const NetworkFailure()));

      final result = await SubmitBillPaymentUseCase(repository)(
        const SubmitBillPaymentParams(amount: 50, billType: 'water'),
      );
      expect(result, testLeftVoid(const NetworkFailure()));
    });
  });

  group('Notifications use cases', () {
    test('MarkNotificationReadUseCase delegates index', () async {
      final repository = MockNotificationsRepository();
      when(
        () => repository.markNotificationRead(0),
      ).thenAnswer((_) async => Right([TestFixtures.notification]));

      final result = await MarkNotificationReadUseCase(repository)(
        const MarkNotificationReadParams(0),
      );
      expect(result.fold((l) => 0, (r) => r.length), 1);
    });
  });

  group('Profile use cases', () {
    test('GetProfileDataUseCase returns profile', () async {
      final repository = MockProfileRepository();
      when(
        () => repository.getProfileData(),
      ).thenAnswer((_) async => Right(TestFixtures.profileData));

      final result = await GetProfileDataUseCase(repository)(const NoParams());
      expect(result.isRight(), isTrue);
    });
  });

  group('Settings use cases', () {
    test('SetThemeModeUseCase delegates theme', () async {
      final repository = MockSettingsRepository();
      when(
        () => repository.setThemeMode(ThemeMode.dark),
      ).thenAnswer((_) async => futureRightVoid());

      final result = await SetThemeModeUseCase(repository)(
        const SetThemeModeParams(ThemeMode.dark),
      );
      expect(result, testRightVoid);
    });

    test('SetLocaleUseCase delegates locale', () async {
      final repository = MockSettingsRepository();
      when(
        () => repository.setLocale(const Locale('ar')),
      ).thenAnswer((_) async => futureRightVoid());

      final result = await SetLocaleUseCase(repository)(
        const SetLocaleParams(Locale('ar')),
      );
      expect(result, testRightVoid);
    });
  });
}
