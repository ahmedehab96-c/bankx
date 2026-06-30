import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Firebase configuration for project `bankx-app-c0958`.
///
/// Platform files: `android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`
/// Enable with `--dart-define=FIREBASE_CONFIGURED=true` (staging/production env JSON).
class DefaultFirebaseOptions {
  static const bool isConfigured = bool.fromEnvironment(
    'FIREBASE_CONFIGURED',
    defaultValue: false,
  );

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        return android;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBu8T6MAeTXQJcda7qlxo_tgB11pzn0vBg',
    appId: '1:184700813147:android:8e939a394a823118e1e47e',
    messagingSenderId: '184700813147',
    projectId: 'bankx-app-c0958',
    storageBucket: 'bankx-app-c0958.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBu8T6MAeTXQJcda7qlxo_tgB11pzn0vBg',
    appId: '1:184700813147:android:8e939a394a823118e1e47e',
    messagingSenderId: '184700813147',
    projectId: 'bankx-app-c0958',
    storageBucket: 'bankx-app-c0958.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGDGOpkhKgB_nzNQxbDfVoLCF0KatEyC8',
    appId: '1:184700813147:ios:55955d89bec707b5e1e47e',
    messagingSenderId: '184700813147',
    projectId: 'bankx-app-c0958',
    storageBucket: 'bankx-app-c0958.firebasestorage.app',
    iosBundleId: 'com.bankx.bankx',
  );
}
