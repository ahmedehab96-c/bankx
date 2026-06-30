import 'package:bankx/core/ai/datasources/fx_rates_remote_data_source.dart';
import 'package:bankx/core/ai/engines/currency_converter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('FxRatesRemoteDataSource', () {
    test('maps API rates to AED equivalents', () async {
      final dio = MockDio();
      when(() => dio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => Response(
          data: {
            'result': 'success',
            'base_code': 'AED',
            'rates': {'USD': 0.272294, 'EUR': 0.251},
          },
          requestOptions: RequestOptions(),
        ),
      );

      final source = FxRatesRemoteDataSource(
        dio: dio,
        apiUrl: 'https://example.com/rates',
      );
      final rates = await source.fetchRatesToAed();

      expect(rates['AED'], 1.0);
      expect(rates['USD']!, closeTo(3.6725, 0.01));
      expect(rates['EUR']!, closeTo(3.984, 0.01));
    });
  });

  group('CurrencyConverter', () {
    test('convert uses cached rates', () async {
      final dio = MockDio();
      when(() => dio.get<Map<String, dynamic>>(any())).thenAnswer(
        (_) async => Response(
          data: {
            'result': 'success',
            'rates': {'USD': 0.272294},
          },
          requestOptions: RequestOptions(),
        ),
      );

      final converter = CurrencyConverter(
        fxRates: FxRatesRemoteDataSource(dio: dio, apiUrl: 'https://x'),
      );
      await converter.fetchLiveRates();
      final usd = converter.convert(amount: 100, fromCode: 'AED', toCode: 'USD');
      expect(usd, closeTo(27.23, 0.1));
    });

    test('falls back when API fails', () async {
      final dio = MockDio();
      when(() => dio.get<Map<String, dynamic>>(any())).thenThrow(
        DioException(requestOptions: RequestOptions()),
      );

      final converter = CurrencyConverter(
        fxRates: FxRatesRemoteDataSource(dio: dio, apiUrl: 'https://x'),
      );
      final list = await converter.fetchLiveRates();
      expect(list.length, 6);
      expect(converter.hasLiveRates, isFalse);
    });
  });
}
