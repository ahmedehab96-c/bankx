import 'package:dartz/dartz.dart';

import '../errors/exceptions.dart';
import '../errors/failures.dart';
import '../network/network_info.dart';
import '../utils/result.dart';

/// Fetches from remote when online, falls back to cache when offline or on error.
class NetworkBoundResource<T> {
  NetworkBoundResource({
    required NetworkInfo networkInfo,
    required Future<T> Function() fetchRemote,
    required Future<T?> Function() fetchLocal,
    required Future<void> Function(T data) saveLocal,
  }) : _networkInfo = networkInfo,
       _fetchRemote = fetchRemote,
       _fetchLocal = fetchLocal,
       _saveLocal = saveLocal;

  final NetworkInfo _networkInfo;
  final Future<T> Function() _fetchRemote;
  final Future<T?> Function() _fetchLocal;
  final Future<void> Function(T data) _saveLocal;

  ResultFuture<T> execute() async {
    try {
      if (await _networkInfo.isConnected) {
        try {
          final remote = await _fetchRemote();
          await _saveLocal(remote);
          return Right(remote);
        } on AppException catch (e) {
          final cached = await _fetchLocal();
          if (cached != null) return Right(cached);
          return Left(mapExceptionToFailure(e));
        } catch (e) {
          final cached = await _fetchLocal();
          if (cached != null) return Right(cached);
          return Left(mapExceptionToFailure(e));
        }
      }

      final cached = await _fetchLocal();
      if (cached != null) return Right(cached);
      return const Left(NetworkFailure());
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}

/// For write operations (transfer, bill pay) — remote only, no cache fallback.
class RemoteResource {
  RemoteResource({required NetworkInfo networkInfo})
    : _networkInfo = networkInfo;

  final NetworkInfo _networkInfo;

  ResultFuture<T> execute<T>(Future<T> Function() action) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure());
    }
    try {
      return Right(await action());
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  ResultFuture<void> executeVoid(Future<void> Function() action) async {
    final result = await execute(action);
    return result.fold((l) => Left(l), (_) => const Right(null));
  }
}
