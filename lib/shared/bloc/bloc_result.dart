import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import 'request_status.dart';

/// Helpers for mapping [Either] results into bloc [RequestStatus] emissions.
abstract final class BlocResult {
  static String failureMessage(Failure failure) => failure.message;

  static RequestStatus statusForList<T>(List<T> items, Failure? failure) {
    if (failure != null) return RequestStatus.failure;
    return RequestStatus.success;
  }
}

extension EitherBlocX<T> on Either<Failure, T> {
  R foldResult<R>({
    required R Function(Failure failure) onFailure,
    required R Function(T data) onSuccess,
  }) => fold(onFailure, onSuccess);
}
