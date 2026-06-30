import 'package:flutter/material.dart';

import '../di/injection.dart';
import 'screenshot_protection_service.dart';

/// Enables screenshot protection while this route is visible.
class SensitiveScreenWrapper extends StatefulWidget {
  const SensitiveScreenWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<SensitiveScreenWrapper> createState() => _SensitiveScreenWrapperState();
}

class _SensitiveScreenWrapperState extends State<SensitiveScreenWrapper> {
  @override
  void initState() {
    super.initState();
    getIt<ScreenshotProtectionService>().enable();
  }

  @override
  void dispose() {
    getIt<ScreenshotProtectionService>().disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
