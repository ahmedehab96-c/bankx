import 'package:local_auth/local_auth.dart';

/// Fingerprint / Face ID authentication via [LocalAuthentication].
class BiometricAuthService {
  BiometricAuthService({LocalAuthentication? localAuth})
    : _localAuth = localAuth ?? LocalAuthentication();

  final LocalAuthentication _localAuth;

  Future<bool> isDeviceSupported() => _localAuth.isDeviceSupported();

  Future<bool> canCheckBiometrics() => _localAuth.canCheckBiometrics;

  Future<List<BiometricType>> getAvailableBiometrics() =>
      _localAuth.getAvailableBiometrics();

  /// Returns `true` when the user successfully authenticates.
  Future<bool> authenticate({
    String reason = 'Authenticate to access BankX',
  }) async {
    if (!await canCheckBiometrics()) return false;
    return _localAuth.authenticate(
      localizedReason: reason,
      options: const AuthenticationOptions(
        biometricOnly: false,
        stickyAuth: true,
      ),
    );
  }
}
