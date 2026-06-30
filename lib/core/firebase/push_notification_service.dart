import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../navigation/app_navigator.dart';
import 'firebase_bootstrap.dart';

/// Background FCM handler — must be a top-level function.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('FCM background: ${message.messageId}');
}

/// Firebase Cloud Messaging with local notification display and deep links.
class PushNotificationService {
  PushNotificationService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
  })  : _messaging = messaging ?? FirebaseMessaging.instance,
        _localNotifications =
            localNotifications ?? FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  final List<RemoteMessage> _history = [];

  List<RemoteMessage> get history => List.unmodifiable(_history);

  StreamSubscription<RemoteMessage>? _foregroundSub;
  StreamSubscription<RemoteMessage>? _openedAppSub;

  Future<void> initialize({GoRouter? router}) async {
    if (!FirebaseBootstrap.isInitialized) return;

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null && payload.isNotEmpty) {
          router?.go(payload);
        }
      },
    );

    await _messaging.requestPermission();

    _foregroundSub = FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    _openedAppSub =
        FirebaseMessaging.onMessageOpenedApp.listen(_onOpenedApp);

    final initial = await _messaging.getInitialMessage();
    if (initial != null) _onOpenedApp(initial);
  }

  void _onForegroundMessage(RemoteMessage message) {
    _history.insert(0, message);
    final notification = message.notification;
    if (notification == null) return;
    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'bankx_push',
          'BankX Notifications',
          importance: Importance.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: message.data['route'] as String?,
    );
  }

  void _onOpenedApp(RemoteMessage message) {
    _history.insert(0, message);
    final route = message.data['route'] as String?;
    if (route != null && route.isNotEmpty) {
      appNavigatorKey.currentContext?.go(route);
    }
  }

  Future<void> dispose() async {
    await _foregroundSub?.cancel();
    await _openedAppSub?.cancel();
    _foregroundSub = null;
    _openedAppSub = null;
  }
}
