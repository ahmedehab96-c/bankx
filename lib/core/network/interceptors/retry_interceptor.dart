import 'package:dio/dio.dart';

import '../api_client.dart';

/// Retries idempotent GET requests on transient network failures.
class RetryInterceptor extends ApiInterceptor {
  RetryInterceptor(
    this._dio, {
    this.maxRetries = 2,
    this.retryDelay = const Duration(milliseconds: 400),
  });

  final Dio _dio;
  final int maxRetries;
  final Duration retryDelay;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = (options.extra['retry_attempt'] as int?) ?? 0;

    if (!_shouldRetry(err) || attempt >= maxRetries) {
      return handler.next(err);
    }

    await Future<void>.delayed(retryDelay * (attempt + 1));
    options.extra['retry_attempt'] = attempt + 1;

    try {
      final response = await _dio.fetch<dynamic>(options);
      return handler.resolve(response);
    } on DioException catch (retryError) {
      return handler.next(retryError);
    }
  }

  bool _shouldRetry(DioException err) {
    if (err.requestOptions.method.toUpperCase() != 'GET') return false;
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError;
  }
}
