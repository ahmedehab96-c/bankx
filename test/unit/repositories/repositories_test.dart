import 'package:bankx/core/errors/exceptions.dart';
import 'package:bankx/core/errors/failures.dart';
import 'package:bankx/features/accounts/data/repositories/accounts_repository_impl.dart';
import 'package:bankx/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bankx/features/cards/data/repositories/cards_repository_impl.dart';
import 'package:bankx/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:bankx/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:bankx/features/payments/data/repositories/payments_repository_impl.dart';
import 'package:bankx/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:bankx/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:bankx/features/transactions/data/repositories/transactions_repository_impl.dart';
import 'package:bankx/features/transfer/data/repositories/transfer_repository_impl.dart';
import 'package:bankx/shared/domain/entities/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_api_responses.dart';
import '../../helpers/mock_definitions.dart';
import '../../helpers/result_helpers.dart';
import '../../helpers/test_fixtures.dart';

void main() {
  late MockNetworkInfo network;

  setUp(() {
    network = MockNetworkInfo();
    registerFallbackValues();
  });

  group('AuthRepositoryImpl', () {
    late MockAuthRemoteDataSource remote;
    late MockAuthLocalDataSource local;
    late AuthRepositoryImpl repository;

    setUp(() {
      remote = MockAuthRemoteDataSource();
      local = MockAuthLocalDataSource();
      repository = AuthRepositoryImpl(
        remote: remote,
        local: local,
        networkInfo: network,
      );
    });

    test('login saves session on success', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.login(email: any(named: 'email'), password: any(named: 'password')))
          .thenAnswer((_) async => FakeApiResponses.login);
      when(() => local.saveSession(any())).thenAnswer((_) async {});

      final result = await repository.login(email: 'a@b.com', password: 'pass');
      expect(result, testRightVoid);
      verify(() => local.saveSession(FakeApiResponses.login)).called(1);
    });

    test('login returns NetworkFailure when offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      final result = await repository.login(email: 'a@b.com', password: 'pass');
      expect(result, testLeftVoid(const NetworkFailure()));
    });

    test('logout clears session even when remote fails', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.logout()).thenThrow(const ServerException());
      when(() => local.clearSession()).thenAnswer((_) async {});

      final result = await repository.logout();
      expect(result.isLeft(), isTrue);
      verify(() => local.clearSession()).called(1);
    });

    test('isAuthenticated reads local session', () async {
      when(() => local.hasSession()).thenAnswer((_) async => true);
      final result = await repository.isAuthenticated();
      expect(result, testRight(true));
    });
  });

  group('DashboardRepositoryImpl', () {
    late MockDashboardRemoteDataSource remote;
    late MockDashboardLocalDataSource local;
    late DashboardRepositoryImpl repository;

    setUp(() {
      remote = MockDashboardRemoteDataSource();
      local = MockDashboardLocalDataSource();
      repository = DashboardRepositoryImpl(
        remote: remote,
        local: local,
        networkInfo: network,
      );
    });

    test('getDashboardData fetches remote when online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.fetchDashboardData()).thenAnswer((_) async => TestFixtures.dashboardData);

      final result = await repository.getDashboardData();
      expect(result.isRight(), isTrue);
      result.fold((_) => fail('expected success'), (data) {
        expect(data.totalBalance, TestFixtures.dashboardData.totalBalance);
      });
    });

    test('getDashboardData uses cache when offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      when(() => local.getCachedDashboardData()).thenAnswer((_) async => TestFixtures.dashboardData);

      final result = await repository.getDashboardData();
      expect(result.isRight(), isTrue);
      result.fold((_) => fail('expected success'), (data) {
        expect(data.totalBalance, TestFixtures.dashboardData.totalBalance);
      });
    });

    test('getAnalyticsData returns NetworkFailure without cache', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      when(() => local.getCachedAnalyticsData()).thenAnswer((_) async => null);

      final result = await repository.getAnalyticsData();
      expect(result, testLeftVoid(const NetworkFailure()));
    });
  });

  group('AccountsRepositoryImpl', () {
    late MockAccountsRemoteDataSource remote;
    late MockAccountsLocalDataSource local;
    late AccountsRepositoryImpl repository;

    setUp(() {
      remote = MockAccountsRemoteDataSource();
      local = MockAccountsLocalDataSource();
      repository = AccountsRepositoryImpl(
        remote: remote,
        local: local,
        networkInfo: network,
      );
    });

    test('getAccountById returns remote account online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.fetchAccountById('acc-1')).thenAnswer((_) async => TestFixtures.account);

      final result = await repository.getAccountById('acc-1');
      expect(result.isRight(), isTrue);
    });
  });

  group('TransactionsRepositoryImpl', () {
    late MockTransactionsRemoteDataSource remote;
    late MockTransactionsLocalDataSource local;
    late TransactionsRepositoryImpl repository;

    setUp(() {
      remote = MockTransactionsRemoteDataSource();
      local = MockTransactionsLocalDataSource();
      repository = TransactionsRepositoryImpl(
        remote: remote,
        local: local,
        networkInfo: network,
      );
    });

    test('getTransactions filters cached list by type', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      when(() => local.getCachedTransactions()).thenAnswer(
        (_) async => [TestFixtures.transaction],
      );

      final result = await repository.getTransactions(
        type: TestFixtures.transaction.type,
      );
      expect(result.fold((l) => 0, (r) => r.length), 1);
    });
  });

  group('TransferRepositoryImpl', () {
    late MockTransferRemoteDataSource remote;
    late MockTransferLocalDataSource local;
    late FakeCacheStorage cache;
    late TransferRepositoryImpl repository;

    setUp(() {
      remote = MockTransferRemoteDataSource();
      local = MockTransferLocalDataSource();
      cache = FakeCacheStorage();
      repository = TransferRepositoryImpl(
        remote: remote,
        local: local,
        networkInfo: network,
        cache: cache,
      );
    });

    test('queues transfer when offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      final result = await repository.transfer(
        fromAccountId: 'a1',
        beneficiaryId: 'b1',
        amount: 100,
      );
      expect(result, testRightVoid);
      expect(cache.queue, hasLength(1));
    });

    test('submits transfer when online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(
        () => remote.submitTransfer(
          fromAccountId: any(named: 'fromAccountId'),
          beneficiaryId: any(named: 'beneficiaryId'),
          amount: any(named: 'amount'),
          note: any(named: 'note'),
        ),
      ).thenAnswer((_) async {});

      final result = await repository.transfer(
        fromAccountId: 'a1',
        beneficiaryId: 'b1',
        amount: 50,
      );
      expect(result, testRightVoid);
    });
  });

  group('CardsRepositoryImpl', () {
    late MockCardsRemoteDataSource remote;
    late MockCardsLocalDataSource local;
    late CardsRepositoryImpl repository;

    setUp(() {
      remote = MockCardsRemoteDataSource();
      local = MockCardsLocalDataSource();
      repository = CardsRepositoryImpl(
        remote: remote,
        local: local,
        networkInfo: network,
      );
    });

    test('toggleCardFreeze requires network', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      final result = await repository.toggleCardFreeze('card-1');
      expect(result, testLeftVoid(const NetworkFailure()));
    });

    test('toggleCardFreeze returns updated card', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      final frozen = TestFixtures.card.copyWith(status: CardStatus.frozen);
      when(() => remote.toggleCardFreeze('card-1')).thenAnswer((_) async => frozen);

      final result = await repository.toggleCardFreeze('card-1');
      expect(result.isRight(), isTrue);
      result.fold((_) => fail('expected success'), (card) {
        expect(card.status, CardStatus.frozen);
      });
    });
  });

  group('PaymentsRepositoryImpl', () {
    late MockPaymentsRemoteDataSource remote;
    late MockPaymentsLocalDataSource local;
    late PaymentsRepositoryImpl repository;

    setUp(() {
      remote = MockPaymentsRemoteDataSource();
      local = MockPaymentsLocalDataSource();
      repository = PaymentsRepositoryImpl(
        remote: remote,
        local: local,
        networkInfo: network,
      );
    });

    test('getQrPaymentData returns cached data offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      when(() => local.getCachedQrPaymentData()).thenAnswer((_) async => TestFixtures.qrPaymentData);

      final result = await repository.getQrPaymentData();
      expect(result.isRight(), isTrue);
    });

    test('submitBillPayment fails offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      final result = await repository.submitBillPayment(amount: 100, billType: 'electricity');
      expect(result, testLeftVoid(const NetworkFailure()));
    });
  });

  group('NotificationsRepositoryImpl', () {
    late MockNotificationsRemoteDataSource remote;
    late MockNotificationsLocalDataSource local;
    late NotificationsRepositoryImpl repository;

    setUp(() {
      remote = MockNotificationsRemoteDataSource();
      local = MockNotificationsLocalDataSource();
      repository = NotificationsRepositoryImpl(
        remote: remote,
        local: local,
        networkInfo: network,
      );
    });

    test('getNotifications returns remote list online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.fetchNotifications()).thenAnswer((_) async => [TestFixtures.notification]);

      final result = await repository.getNotifications();
      expect(result.fold((l) => 0, (r) => r.length), 1);
    });
  });

  group('ProfileRepositoryImpl', () {
    late MockProfileRemoteDataSource remote;
    late MockProfileLocalDataSource local;
    late ProfileRepositoryImpl repository;

    setUp(() {
      remote = MockProfileRemoteDataSource();
      local = MockProfileLocalDataSource();
      repository = ProfileRepositoryImpl(
        remote: remote,
        local: local,
        networkInfo: network,
      );
    });

    test('getProfileData returns cached profile offline', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      when(() => local.getCachedProfileData()).thenAnswer((_) async => TestFixtures.profileData);

      final result = await repository.getProfileData();
      expect(result.isRight(), isTrue);
    });
  });

  group('SettingsRepositoryImpl', () {
    late MockSettingsRemoteDataSource remote;
    late MockSettingsLocalDataSource local;
    late SettingsRepositoryImpl repository;

    setUp(() {
      remote = MockSettingsRemoteDataSource();
      local = MockSettingsLocalDataSource();
      repository = SettingsRepositoryImpl(
        remote: remote,
        local: local,
        networkInfo: network,
      );
    });

    test('getSettings persists theme and locale from remote', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => remote.fetchSettings()).thenAnswer((_) async => FakeApiResponses.settings);
      when(() => local.saveThemeMode(any())).thenAnswer((_) async {});
      when(() => local.saveLocale(any())).thenAnswer((_) async {});

      final result = await repository.getSettings();
      expect(result.isRight(), isTrue);
      result.fold((_) => fail('expected success'), (bundle) {
        expect(bundle.themeMode, ThemeMode.light);
        expect(bundle.locale.languageCode, 'en');
      });
    });

    test('setThemeMode syncs to remote when online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      when(() => local.saveThemeMode(ThemeMode.dark)).thenAnswer((_) async {});
      when(() => remote.syncThemeMode(ThemeMode.dark)).thenAnswer((_) async {});

      final result = await repository.setThemeMode(ThemeMode.dark);
      expect(result, testRightVoid);
    });
  });
}
