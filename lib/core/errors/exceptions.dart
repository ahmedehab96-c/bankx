import 'failures.dart';

/// Base application exception thrown by the data layer.
class AppException implements Exception {
  const AppException(this.message, {this.code, this.statusCode});

  final String message;
  final String? code;
  final int? statusCode;

  @override
  String toString() => message;
}

class ServerException extends AppException {
  const ServerException([
    super.message = 'Server error',
    String? code,
    int? statusCode,
  ]) : super(code: code, statusCode: statusCode);
}

class CacheException extends AppException {
  const CacheException([super.message = 'Cache error']);
}

class NotFoundException extends AppException {
  const NotFoundException([
    super.message = 'Resource not found',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Unauthorized',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class ForbiddenException extends AppException {
  const ForbiddenException([
    super.message = 'Forbidden',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class ApiTimeoutException extends AppException {
  const ApiTimeoutException([super.message = 'Request timeout']);
}

class ConflictException extends AppException {
  const ConflictException([
    super.message = 'Conflict',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class ValidationException extends AppException {
  const ValidationException([
    super.message = 'Validation error',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class TooManyRequestsException extends AppException {
  const TooManyRequestsException([
    super.message = 'Too many requests',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

class NetworkSocketException extends AppException {
  const NetworkSocketException([super.message = 'Network socket error']);
}

Failure mapExceptionToFailure(Object error) {
  return switch (error) {
    UnauthorizedException() => UnauthorizedFailure(error.message, error.code),
    ForbiddenException() => ForbiddenFailure(error.message, error.code),
    NotFoundException() => NotFoundFailure(error.message, error.code),
    ApiTimeoutException() => TimeoutFailure(error.message, error.code),
    ConflictException() => ConflictFailure(error.message, error.code),
    ValidationException() => ValidationFailure(error.message, error.code),
    TooManyRequestsException() =>
      TooManyRequestsFailure(error.message, error.code),
    NetworkException() => NetworkFailure(error.message, error.code),
    NetworkSocketException() => SocketFailure(error.message, error.code),
    CacheException() => CacheFailure(error.message, error.code),
    AppException() => ServerFailure(error.message, error.code),
    _ => UnknownFailure(error.toString()),
  };
}
