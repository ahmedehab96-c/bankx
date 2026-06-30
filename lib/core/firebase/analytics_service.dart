import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

import 'firebase_bootstrap.dart';

/// Wraps Firebase Analytics for banking event tracking.
class AnalyticsService {
  AnalyticsService({FirebaseAnalytics? analytics})
      : _analyticsOverride = analytics;

  final FirebaseAnalytics? _analyticsOverride;
  FirebaseAnalytics? _analytics;

  FirebaseAnalytics? get _client {
    if (!FirebaseBootstrap.isInitialized) return null;
    return _analyticsOverride ?? (_analytics ??= FirebaseAnalytics.instance);
  }

  bool get _enabled => _client != null && !kDebugMode;

  Future<void> logLogin({String method = 'email'}) async {
    if (!_enabled) return;
    await _client!.logLogin(loginMethod: method);
  }

  Future<void> logTransfer({required double amount, required String currency}) async {
    if (!_enabled) return;
    await _client!.logEvent(
      name: 'transfer',
      parameters: {'amount': amount, 'currency': currency},
    );
  }

  Future<void> logPayment({required String type, required double amount}) async {
    if (!_enabled) return;
    await _client!.logEvent(
      name: 'payment',
      parameters: {'type': type, 'amount': amount},
    );
  }

  Future<void> logCardAction({required String action, required String cardId}) async {
    if (!_enabled) return;
    await _client!.logEvent(
      name: 'card_action',
      parameters: {'action': action, 'card_id': cardId},
    );
  }

  Future<void> logError({required String code, String? message}) async {
    if (!_enabled) return;
    await _client!.logEvent(
      name: 'app_error',
      parameters: {'code': code, 'message': ?message},
    );
  }
}
