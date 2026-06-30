import 'package:bankx/core/errors/failures.dart';
import 'package:bankx/core/network/network_info.dart';
import 'package:bankx/core/storage/cache_storage_service.dart';
import 'package:bankx/features/accounts/data/datasources/accounts_local_data_source.dart';
import 'package:bankx/features/accounts/data/datasources/accounts_remote_data_source.dart';
import 'package:bankx/features/accounts/domain/repositories/accounts_repository.dart';
import 'package:bankx/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:bankx/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bankx/features/auth/domain/repositories/auth_repository.dart';
import 'package:bankx/features/cards/data/datasources/cards_local_data_source.dart';
import 'package:bankx/features/cards/data/datasources/cards_remote_data_source.dart';
import 'package:bankx/features/cards/domain/repositories/cards_repository.dart';
import 'package:bankx/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:bankx/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:bankx/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:bankx/features/notifications/data/datasources/notifications_local_data_source.dart';
import 'package:bankx/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:bankx/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:bankx/features/payments/data/datasources/payments_local_data_source.dart';
import 'package:bankx/features/payments/data/datasources/payments_remote_data_source.dart';
import 'package:bankx/features/payments/domain/repositories/payments_repository.dart';
import 'package:bankx/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:bankx/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:bankx/features/profile/domain/repositories/profile_repository.dart';
import 'package:bankx/features/security/domain/repositories/security_repository.dart';
import 'package:bankx/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:bankx/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:bankx/features/settings/domain/repositories/settings_repository.dart';
import 'package:bankx/features/transactions/data/datasources/transactions_local_data_source.dart';
import 'package:bankx/features/transactions/data/datasources/transactions_remote_data_source.dart';
import 'package:bankx/features/transactions/domain/repositories/transactions_repository.dart';
import 'package:bankx/features/transfer/data/datasources/transfer_local_data_source.dart';
import 'package:bankx/features/transfer/data/datasources/transfer_remote_data_source.dart';
import 'package:bankx/features/transfer/domain/repositories/transfer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';

import 'test_fixtures.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class FakeCacheStorage extends Fake implements CacheStorageService {
  final Map<String, Map<String, dynamic>> cache = {};
  final List<Map<String, dynamic>> queue = [];

  @override
  Future<void> write(
    String key,
    Map<String, dynamic> json, {
    Duration? ttl,
  }) async {
    cache[key] = json;
  }

  @override
  Future<Map<String, dynamic>?> read(String key) async => cache[key];

  @override
  Future<void> enqueueTransfer(Map<String, dynamic> request) async {
    queue.add(request);
  }

  @override
  Future<List<Map<String, dynamic>>> pendingTransfers() async => queue;
}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockDashboardRepository extends Mock implements DashboardRepository {}

class MockAccountsRepository extends Mock implements AccountsRepository {}

class MockTransactionsRepository extends Mock
    implements TransactionsRepository {}

class MockTransferRepository extends Mock implements TransferRepository {}

class MockCardsRepository extends Mock implements CardsRepository {}

class MockPaymentsRepository extends Mock implements PaymentsRepository {}

class MockNotificationsRepository extends Mock
    implements NotificationsRepository {}

class MockProfileRepository extends Mock implements ProfileRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

class MockSecurityRepository extends Mock implements SecurityRepository {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockDashboardRemoteDataSource extends Mock
    implements DashboardRemoteDataSource {}

class MockDashboardLocalDataSource extends Mock
    implements DashboardLocalDataSource {}

class MockAccountsRemoteDataSource extends Mock
    implements AccountsRemoteDataSource {}

class MockAccountsLocalDataSource extends Mock
    implements AccountsLocalDataSource {}

class MockTransactionsRemoteDataSource extends Mock
    implements TransactionsRemoteDataSource {}

class MockTransactionsLocalDataSource extends Mock
    implements TransactionsLocalDataSource {}

class MockTransferRemoteDataSource extends Mock
    implements TransferRemoteDataSource {}

class MockTransferLocalDataSource extends Mock
    implements TransferLocalDataSource {}

class MockCardsRemoteDataSource extends Mock implements CardsRemoteDataSource {}

class MockCardsLocalDataSource extends Mock implements CardsLocalDataSource {}

class MockPaymentsRemoteDataSource extends Mock
    implements PaymentsRemoteDataSource {}

class MockPaymentsLocalDataSource extends Mock
    implements PaymentsLocalDataSource {}

class MockNotificationsRemoteDataSource extends Mock
    implements NotificationsRemoteDataSource {}

class MockNotificationsLocalDataSource extends Mock
    implements NotificationsLocalDataSource {}

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource {}

class MockProfileLocalDataSource extends Mock
    implements ProfileLocalDataSource {}

class MockSettingsRemoteDataSource extends Mock
    implements SettingsRemoteDataSource {}

class MockSettingsLocalDataSource extends Mock
    implements SettingsLocalDataSource {}

class MemorySecureStorage extends FlutterSecureStorage {
  MemorySecureStorage(this._store) : super();

  final Map<String, String> _store;

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _store.remove(key);
  }

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async => _store[key];

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) _store[key] = value;
  }
}

void registerFallbackValues() {
  registerFallbackValue(const UnauthorizedFailure());
  registerFallbackValue(TestFixtures.authResponse);
  registerFallbackValue(ThemeMode.light);
  registerFallbackValue(const Locale('en'));
}
