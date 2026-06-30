/// Base contract for domain use cases.
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

/// Marker for use cases that take no parameters.
class NoParams {
  const NoParams();
}
