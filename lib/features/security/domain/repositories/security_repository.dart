/// Domain contract for app security preferences and checks.
abstract class SecurityRepository {
  Future<bool> isBiometricEnabled();
  Future<void> setBiometricEnabled(bool enabled);
  Future<bool> authenticateWithBiometrics();
  Future<bool> canUseBiometrics();
  Future<bool> isPinSet();
  Future<void> setPin(String pin);
  Future<bool> verifyPin(String pin);
  Future<bool> isDeviceSecure();
  Future<bool> isRooted();
  Future<bool> isJailbroken();
}
