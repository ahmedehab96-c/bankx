import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import 'firebase_bootstrap.dart';

/// Wraps Firebase Analytics for banking event tracking.
class AnalyticsService {
  AnalyticsService({FirebaseAnalytics? analytics})
      : _analytics = analytics ?? FirebaseAnalytics.instance;

  final FirebaseAnalytics _analytics;

  bool get _enabled => FirebaseBootstrap.isInitialized && !kDebugMode;

  Future<void> logLogin({String method = 'email'}) async {
    if (!_enabled) return;
    await _analytics.logLogin(loginMethod: method);
  }

  Future<void> logTransfer({required double amount, required String currency}) async {
    if (!_enabled) return;
    await _analytics.logEvent(
      name: 'transfer',
      parameters: {'amount': amount, 'currency': currency},
    );
  }

  Future<void> logPayment({required String type, required double amount}) async {
    if (!_enabled) return;
    await _analytics.logEvent(
      name: 'payment',
      parameters: {'type': type, 'amount': amount},
    );
  }

  Future<void> logCardAction({required String action, required String cardId}) async {
    if (!_enabled) return;
    await _analytics.logEvent(
      name: 'card_action',
      parameters: {'action': action, 'card_id': cardId},
    );
  }

  Future<void> logError({required String code, String? message}) async {
    if (!_enabled) return;
    await _analytics.logEvent(
      name: 'app_error',
      parameters: {'code': code, 'message': ?message},
    );
  }
}
