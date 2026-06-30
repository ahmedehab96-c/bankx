
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import 'firebase_bootstrap.dart';

/// Captures uncaught errors and routes them to Firebase Crashlytics.
abstract final class CrashlyticsService {
  static Future<void> initialize() async {
    if (!FirebaseBootstrap.isInitialized) return;

    FlutterError.onError = (details) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static Future<void> recordError(
    Object error,
    StackTrace stack, {
    bool fatal = false,
  }) async {
    if (!FirebaseBootstrap.isInitialized) return;
    await FirebaseCrashlytics.instance.recordError(error, stack, fatal: fatal);
  }
}
