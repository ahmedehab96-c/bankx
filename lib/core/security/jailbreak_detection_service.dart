import 'device_integrity_service.dart';

/// Jailbreak detection interface — delegates to [DeviceIntegrityChecker].
abstract class JailbreakDetectionService {
  Future<bool> isJailbroken();
}

class JailbreakDetectionServiceImpl implements JailbreakDetectionService {
  JailbreakDetectionServiceImpl(this._checker);

  final DeviceIntegrityChecker _checker;

  @override
  Future<bool> isJailbroken() => _checker.isRootedOrJailbroken();
}
