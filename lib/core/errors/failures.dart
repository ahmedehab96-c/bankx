/// Base failure type for domain-layer error handling.
sealed class Failure {
  const Failure(this.message, {this.code});

  final String message;
  final String? code;
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error', String? code])
      : super(code: code);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error', String? code])
      : super(code: code);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found', String? code])
      : super(code: code);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Unauthorized', String? code])
      : super(code: code);
}

final class ForbiddenFailure extends Failure {
  const ForbiddenFailure([super.message = 'Forbidden', String? code])
      : super(code: code);
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Request timeout', String? code])
      : super(code: code);
}

final class ConflictFailure extends Failure {
  const ConflictFailure([super.message = 'Conflict', String? code])
      : super(code: code);
}

final class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation error', String? code])
      : super(code: code);
}

final class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure([
    super.message = 'Too many requests',
    String? code,
  ]) : super(code: code);
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection', String? code])
      : super(code: code);
}

final class SocketFailure extends Failure {
  const SocketFailure([super.message = 'Network socket error', String? code])
      : super(code: code);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Unknown error', String? code])
      : super(code: code);
}

final class EmptyFailure extends Failure {
  const EmptyFailure([super.message = 'No data available', String? code])
      : super(code: code);
}
