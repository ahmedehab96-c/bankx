import 'package:dartz/dartz.dart';

import '../errors/failures.dart';

/// Shorthand for repository / use-case results.
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// Maps [Either] to a value or throws — for tests only.
extension EitherX<T> on Either<Failure, T> {
  T getOrThrow() => fold((l) => throw Exception(l.message), (r) => r);
}
