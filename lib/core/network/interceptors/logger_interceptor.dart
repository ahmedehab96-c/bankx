import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../api_client.dart';

/// Pretty-prints HTTP traffic in debug builds.
class LoggerInterceptor extends ApiInterceptor {
  LoggerInterceptor(this._logger);

  final PrettyDioLogger _logger;

  static LoggerInterceptor create() => LoggerInterceptor(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logger.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.onError(err, handler);
  }
}
