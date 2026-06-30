import 'device_integrity_service.dart';

/// Root detection interface — delegates to [DeviceIntegrityChecker].
abstract class RootDetectionService {
  Future<bool> isRooted();
}

class RootDetectionServiceImpl implements RootDetectionService {
  RootDetectionServiceImpl(this._checker);

  final DeviceIntegrityChecker _checker;

  @override
  Future<bool> isRooted() => _checker.isRootedOrJailbroken();
}
