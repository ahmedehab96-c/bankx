/// Base failure type for domain-layer error handling.
sealed class Failure {
  const Failure(this.message);

  final String message;
}

final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error']);
}

final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error']);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found']);
}
