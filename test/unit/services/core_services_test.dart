import 'package:bankx/core/cache/cache_policy.dart';
import 'package:bankx/core/errors/exceptions.dart';
import 'package:bankx/core/errors/failures.dart';
import 'package:bankx/core/network/api_error_mapper.dart';
import 'package:bankx/core/network/network_bound_resource.dart';
import 'package:bankx/core/qr/qr_payment_codec.dart';
import 'package:bankx/core/security/pin_lock_service.dart';
import 'package:bankx/core/storage/secure_storage_service.dart';
import 'package:bankx/core/utils/responsive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_definitions.dart';
import '../../helpers/result_helpers.dart';

void main() {
  group('QrPaymentCodec', () {
    test('round-trips receive payload', () {
      final raw = QrPaymentCodec.encodeReceive(
        accountNumber: '123',
        iban: 'AE1',
        name: 'Ahmed',
        amount: 100,
      );
      final decoded = QrPaymentCodec.decode(raw);
      expect(decoded?['name'], 'Ahmed');
      expect(decoded?['amount'], 100);
    });

    test('returns null for invalid payload', () {
      expect(QrPaymentCodec.decode('not-json'), isNull);
    });
  });

  group('CachePolicy', () {
    test('maps known cache keys to TTL', () {
      expect(CachePolicy.forKey('cache_dashboard'), CachePolicy.dashboard);
      expect(CachePolicy.forKey('cache_card_x'), CachePolicy.cards);
    });
  });

  group('AppFormatters', () {
    test('formats currency with symbol', () {
      expect(AppFormatters.currency(1234.5), 'AED 1,234.50');
    });

    test('formats compact currency for thousands', () {
      expect(AppFormatters.compactCurrency(2500), 'AED 2.5K');
    });

    test('formats time ago for recent dates', () {
      final recent = DateTime.now().subtract(const Duration(minutes: 5));
      expect(AppFormatters.timeAgo(recent), '5m ago');
    });
  });

  group('Responsive', () {
    testWidgets('detects phone vs tablet width', (tester) async {
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(Responsive.isTablet(context), isFalse);
              return const SizedBox();
            },
          ),
        ),
      );

      tester.view.physicalSize = const Size(800, 1200);
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(Responsive.isTablet(context), isTrue);
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });

  group('ApiErrorMapper', () {
    const mapper = ApiErrorMapper();

    test('maps 401 to UnauthorizedException', () {
      final error = DioException(
        requestOptions: RequestOptions(),
        response: Response(requestOptions: RequestOptions(), statusCode: 401),
        type: DioExceptionType.badResponse,
      );
      expect(mapper.mapDioException(error), isA<UnauthorizedException>());
    });

    test('maps timeout to ApiTimeoutException', () {
      final error = DioException(
        requestOptions: RequestOptions(),
        type: DioExceptionType.connectionTimeout,
      );
      expect(mapper.mapDioException(error), isA<ApiTimeoutException>());
    });
  });

  group('NetworkBoundResource', () {
    late MockNetworkInfo network;

    setUp(() => network = MockNetworkInfo());

    test('returns remote data when online', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      final resource = NetworkBoundResource<int>(
        networkInfo: network,
        fetchRemote: () async => 42,
        fetchLocal: () async => null,
        saveLocal: (_) async {},
      );
      final result = await resource.execute();
      expect(result, testRight(42));
    });

    test('returns NetworkFailure when offline and no cache', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      final resource = NetworkBoundResource<int>(
        networkInfo: network,
        fetchRemote: () async => 42,
        fetchLocal: () async => null,
        saveLocal: (_) async {},
      );
      final result = await resource.execute();
      expect(result, testLeftVoid(const NetworkFailure()));
    });

    test('falls back to cache when remote throws', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      final resource = NetworkBoundResource<int>(
        networkInfo: network,
        fetchRemote: () async => throw const UnauthorizedException(),
        fetchLocal: () async => 7,
        saveLocal: (_) async {},
      );
      final result = await resource.execute();
      expect(result, testRight(7));
    });
  });

  group('PinLockService', () {
    test('hashes and verifies PIN securely', () async {
      final store = <String, String>{};
      final service = PinLockService(
        SecureStorageService(storage: MemorySecureStorage(store)),
      );
      await service.setPin('1234');
      expect(await service.verifyPin('1234'), isTrue);
      expect(await service.verifyPin('0000'), isFalse);
    });
  });
}
