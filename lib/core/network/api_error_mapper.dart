import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import '../errors/failures.dart';

/// Maps [DioException] and HTTP status codes to typed [AppException]s.
class ApiErrorMapper {
  const ApiErrorMapper();

  AppException mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiTimeoutException();
      case DioExceptionType.connectionError:
        return const NetworkSocketException();
      case DioExceptionType.badResponse:
        return _mapStatusCode(
          error.response?.statusCode,
          _extractMessage(error.response),
        );
      case DioExceptionType.cancel:
        return const ServerException('Request cancelled');
      default:
        return ServerException(error.message ?? 'Network error');
    }
  }

  AppException _mapStatusCode(int? statusCode, String message) {
    if (statusCode != null && statusCode >= 500) {
      return ServerException(message, null, statusCode);
    }
    return switch (statusCode) {
      401 => UnauthorizedException(message, statusCode),
      403 => ForbiddenException(message, statusCode),
      404 => NotFoundException(message, statusCode),
      408 => const ApiTimeoutException(),
      409 => ConflictException(message, statusCode),
      422 => ValidationException(message, statusCode),
      429 => TooManyRequestsException(message, statusCode),
      _ => ServerException(message, null, statusCode),
    };
  }

  String _extractMessage(Response<dynamic>? response) {
    final data = response?.data;
    if (data is Map<String, dynamic>) {
      return (data['message'] as String?) ??
          (data['error'] as String?) ??
          'Request failed';
    }
    return 'Request failed';
  }

  Failure mapToFailure(Object error) => mapExceptionToFailure(
        error is DioException ? mapDioException(error) : error,
      );
}
