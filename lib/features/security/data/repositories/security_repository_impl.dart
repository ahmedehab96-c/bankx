import '../../../../core/security/biometric_auth_service.dart';
import '../../../../core/security/device_integrity_service.dart';
import '../../../../core/security/jailbreak_detection_service.dart';
import '../../../../core/security/pin_lock_service.dart';
import '../../../../core/security/root_detection_service.dart';
import '../../../../core/security/secure_storage_keys.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../domain/repositories/security_repository.dart';

class SecurityRepositoryImpl implements SecurityRepository {
  SecurityRepositoryImpl({
    required BiometricAuthService biometricAuth,
    required PinLockService pinLock,
    required SecureStorageService secureStorage,
    required DeviceIntegrityChecker deviceIntegrity,
    required RootDetectionService rootDetection,
    required JailbreakDetectionService jailbreakDetection,
  }) : _biometricAuth = biometricAuth,
       _pinLock = pinLock,
       _secureStorage = secureStorage,
       _deviceIntegrity = deviceIntegrity,
       _rootDetection = rootDetection,
       _jailbreakDetection = jailbreakDetection;

  final BiometricAuthService _biometricAuth;
  final PinLockService _pinLock;
  final SecureStorageService _secureStorage;
  final DeviceIntegrityChecker _deviceIntegrity;
  final RootDetectionService _rootDetection;
  final JailbreakDetectionService _jailbreakDetection;

  @override
  Future<bool> isBiometricEnabled() async =>
      (await _secureStorage.read(SecurityStorageKeys.biometricEnabled)) ==
      'true';

  @override
  Future<void> setBiometricEnabled(bool enabled) => _secureStorage.write(
    SecurityStorageKeys.biometricEnabled,
    enabled.toString(),
  );

  @override
  Future<bool> authenticateWithBiometrics() => _biometricAuth.authenticate();

  @override
  Future<bool> canUseBiometrics() async =>
      await _biometricAuth.isDeviceSupported() &&
      await _biometricAuth.canCheckBiometrics();

  @override
  Future<bool> isPinSet() => _pinLock.isPinSet();

  @override
  Future<void> setPin(String pin) => _pinLock.setPin(pin);

  @override
  Future<bool> verifyPin(String pin) => _pinLock.verifyPin(pin);

  @override
  Future<bool> isDeviceSecure() => _deviceIntegrity.isDeviceSecure();

  @override
  Future<bool> isRooted() => _rootDetection.isRooted();

  @override
  Future<bool> isJailbroken() => _jailbreakDetection.isJailbroken();
}
