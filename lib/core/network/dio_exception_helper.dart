import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

/// Extracts typed [AppException] from Dio and other data-layer errors.
Never rethrowAsAppException(Object error) {
  if (error is AppException) throw error;
  if (error is DioException) {
    final inner = error.error;
    if (inner is AppException) throw inner;
    throw ServerException(error.message ?? 'Network error');
  }
  throw ServerException(error.toString());
}

/// Returns [AppException] without throwing — for interceptors and mappers.
AppException toAppException(Object error) {
  if (error is AppException) return error;
  if (error is DioException) {
    final inner = error.error;
    if (inner is AppException) return inner;
    return ServerException(error.message ?? 'Network error');
  }
  return ServerException(error.toString());
}
