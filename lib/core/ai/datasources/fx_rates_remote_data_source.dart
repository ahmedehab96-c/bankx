import 'package:dio/dio.dart';

import '../ai_config.dart';

/// Fetches live FX rates with AED as the reference currency.
class FxRatesRemoteDataSource {
  FxRatesRemoteDataSource({Dio? dio, String? apiUrl})
    : _dio = dio ?? Dio(),
      _apiUrl = apiUrl ?? AiConfig.fxApiUrl;

  final Dio _dio;
  final String _apiUrl;

  /// Returns how many AED each currency code is worth (1 unit → AED).
  Future<Map<String, double>> fetchRatesToAed() async {
    final response = await _dio.get<Map<String, dynamic>>(_apiUrl);
    final data = response.data;
    if (data == null) {
      throw StateError('Empty FX API response');
    }

    final result = data['result'] as String?;
    if (result != null && result != 'success') {
      throw StateError('FX API error: $result');
    }

    final rates = data['rates'] as Map<String, dynamic>? ?? {};
    final mapped = <String, double>{'AED': 1.0};

    for (final entry in rates.entries) {
      final perAed = (entry.value as num).toDouble();
      if (perAed <= 0) continue;
      // API returns units of [currency] per 1 AED → AED per 1 unit = 1 / perAed
      mapped[entry.key.toUpperCase()] = 1 / perAed;
    }

    return mapped;
  }
}
