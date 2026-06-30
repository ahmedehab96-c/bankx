import 'package:dartz/dartz.dart';

import '../../../../core/network/network_bound_resource.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required AuthLocalDataSource local,
    required NetworkInfo networkInfo,
  }) : _remote = remote,
       _local = local,
       _remoteResource = RemoteResource(networkInfo: networkInfo);

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;
  final RemoteResource _remoteResource;

  @override
  ResultFuture<void> login({required String email, required String password}) =>
      _remoteResource.executeVoid(() async {
        final response = await _remote.login(email: email, password: password);
        await _local.saveSession(response);
      });

  @override
  ResultFuture<void> register({
    required String name,
    required String email,
    required String password,
  }) => _remoteResource.executeVoid(() async {
    await _remote.register(name: name, email: email, password: password);
  });

  @override
  ResultFuture<void> verifyOtp({required String code}) =>
      _remoteResource.executeVoid(() async {
        final response = await _remote.verifyOtp(code: code);
        await _local.saveSession(response);
      });

  @override
  ResultFuture<void> resetPassword({required String email}) =>
      _remoteResource.executeVoid(() => _remote.forgotPassword(email: email));

  @override
  ResultFuture<void> logout() => _remoteResource.executeVoid(() async {
    try {
      await _remote.logout();
    } finally {
      await _local.clearSession();
    }
  });

  @override
  ResultFuture<bool> isAuthenticated() async {
    final hasSession = await _local.hasSession();
    return Right(hasSession);
  }

  @override
  ResultFuture<bool> refreshTokens() => _remoteResource.execute(() async {
    final refresh = await _local.getRefreshToken();
    if (refresh == null || refresh.isEmpty) return false;
    final tokens = await _remote.refreshToken(refresh);
    await _local.saveTokens(tokens);
    return true;
  });
}
