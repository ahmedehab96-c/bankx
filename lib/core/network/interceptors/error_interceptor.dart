import 'package:dio/dio.dart';

import '../api_client.dart';
import '../api_error_mapper.dart';

/// Converts [DioException] into typed [AppException]s before they reach repositories.
class ErrorInterceptor extends ApiInterceptor {
  ErrorInterceptor({ApiErrorMapper? mapper})
      : _mapper = mapper ?? const ApiErrorMapper();

  final ApiErrorMapper _mapper;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final mapped = _mapper.mapDioException(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: mapped,
        message: mapped.message,
      ),
    );
  }
}
