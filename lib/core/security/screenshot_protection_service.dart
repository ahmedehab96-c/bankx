import 'package:screen_protector/screen_protector.dart';

/// Prevents screenshots and screen recording on sensitive screens.
class ScreenshotProtectionService {
  Future<void> enable() async {
    await ScreenProtector.preventScreenshotOn();
    await ScreenProtector.protectDataLeakageOn();
  }

  Future<void> disable() async {
    await ScreenProtector.preventScreenshotOff();
    await ScreenProtector.protectDataLeakageOff();
  }
}
