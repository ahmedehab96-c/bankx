import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/security_repository.dart';

class SecuritySettings {
  const SecuritySettings({
    required this.biometricEnabled,
    required this.biometricsAvailable,
    required this.deviceSecure,
    required this.isRooted,
  });

  final bool biometricEnabled;
  final bool biometricsAvailable;
  final bool deviceSecure;
  final bool isRooted;
}

class LoadSecuritySettingsUseCase
    implements UseCase<SecuritySettings, NoParams> {
  LoadSecuritySettingsUseCase(this._repository);

  final SecurityRepository _repository;

  @override
  ResultFuture<SecuritySettings> call(NoParams params) async {
    try {
      final biometric = await _repository.isBiometricEnabled();
      final canUse = await _repository.canUseBiometrics();
      final deviceSecure = await _repository.isDeviceSecure();
      final rooted = await _repository.isRooted();
      return Right(
        SecuritySettings(
          biometricEnabled: biometric,
          biometricsAvailable: canUse,
          deviceSecure: deviceSecure,
          isRooted: rooted,
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}

class ToggleBiometricParams {
  const ToggleBiometricParams(this.enabled);
  final bool enabled;
}

class ToggleBiometricUseCase implements UseCase<void, ToggleBiometricParams> {
  ToggleBiometricUseCase(this._repository);

  final SecurityRepository _repository;

  @override
  ResultFuture<void> call(ToggleBiometricParams params) async {
    try {
      if (params.enabled) {
        final ok = await _repository.authenticateWithBiometrics();
        if (!ok) {
          return const Left(ValidationFailure('Biometric verification failed'));
        }
      }
      await _repository.setBiometricEnabled(params.enabled);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}

class BiometricLoginUseCase implements UseCase<bool, NoParams> {
  BiometricLoginUseCase(this._repository);

  final SecurityRepository _repository;

  @override
  ResultFuture<bool> call(NoParams params) async {
    try {
      if (!await _repository.isBiometricEnabled()) {
        return const Right(false);
      }
      final ok = await _repository.authenticateWithBiometrics();
      return Right(ok);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
