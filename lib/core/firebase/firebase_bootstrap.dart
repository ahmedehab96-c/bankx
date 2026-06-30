import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';

/// Initializes Firebase when [DefaultFirebaseOptions.isConfigured] is true.
abstract final class FirebaseBootstrap {
  static bool _initialized = false;

  static bool get isInitialized => _initialized;

  static Future<void> initialize() async {
    if (_initialized || !DefaultFirebaseOptions.isConfigured) return;
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ).timeout(const Duration(seconds: 15));
      _initialized = true;
    } catch (e, st) {
      debugPrint('Firebase init skipped: $e\n$st');
    }
  }
}
