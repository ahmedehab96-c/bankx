import 'package:safe_device/safe_device.dart';

/// Contract for device integrity checks (root, jailbreak, emulator).
abstract class DeviceIntegrityChecker {
  Future<bool> isDeviceSecure();
  Future<bool> isRootedOrJailbroken();
  Future<bool> isRealDevice();
}

/// Production implementation using [SafeDevice].
class SafeDeviceIntegrityChecker implements DeviceIntegrityChecker {
  @override
  Future<bool> isDeviceSecure() async {
    final jailbroken = await SafeDevice.isJailBroken;
    final real = await SafeDevice.isRealDevice;
    final mock = await SafeDevice.isMockLocation;
    return !jailbroken && real && !mock;
  }

  @override
  Future<bool> isRootedOrJailbroken() => SafeDevice.isJailBroken;

  @override
  Future<bool> isRealDevice() => SafeDevice.isRealDevice;
}

/// No-op checker for tests and unsupported platforms.
class NoOpDeviceIntegrityChecker implements DeviceIntegrityChecker {
  @override
  Future<bool> isDeviceSecure() async => true;

  @override
  Future<bool> isRootedOrJailbroken() async => false;

  @override
  Future<bool> isRealDevice() async => true;
}
