import 'dart:async';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../cache/cache_policy.dart';

/// Hive-backed cache with TTL expiration for offline banking data.
class CacheStorageService {
  static const _boxName = 'bankx_response_cache';
  static const _metaExpiresAt = '_expiresAt';

  Box<String>? _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<String>(_boxName);
    await openQueueBox();
    unawaited(purgeExpired());
  }

  /// Removes expired cache envelopes to keep the Hive box compact.
  Future<void> purgeExpired() async {
    final box = _box;
    if (box == null) return;
    final keysToDelete = <dynamic>[];
    for (final key in box.keys) {
      final raw = box.get(key);
      if (raw == null) continue;
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic> &&
            decoded.containsKey(_metaExpiresAt)) {
          final expiresRaw = decoded[_metaExpiresAt] as String?;
          final expiresAt = DateTime.tryParse(expiresRaw ?? '');
          if (expiresAt != null && DateTime.now().isAfter(expiresAt)) {
            keysToDelete.add(key);
          }
        }
      } catch (_) {
        keysToDelete.add(key);
      }
    }
    await box.deleteAll(keysToDelete);
  }

  // ── Response cache ──────────────────────────────────────────────────────────

  Future<void> write(
    String key,
    Map<String, dynamic> json, {
    Duration? ttl,
  }) async {
    final effectiveTtl = ttl ?? CachePolicy.forKey(key);
    final envelope = {
      _metaExpiresAt: DateTime.now().add(effectiveTtl).toIso8601String(),
      'payload': json,
    };
    await _box?.put(key, jsonEncode(envelope));
  }

  Future<Map<String, dynamic>?> read(String key) async {
    final raw = _box?.get(key);
    if (raw == null) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic> && decoded.containsKey('payload')) {
        final expiresRaw = decoded[_metaExpiresAt] as String?;
        if (expiresRaw != null) {
          final expiresAt = DateTime.tryParse(expiresRaw);
          if (expiresAt != null && DateTime.now().isAfter(expiresAt)) {
            await delete(key);
            return null;
          }
        }
        final payload = decoded['payload'];
        if (payload is Map<String, dynamic>) return payload;
      }
      // Legacy format (no envelope)
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {
      return null;
    }
    return null;
  }

  Future<void> delete(String key) async => _box?.delete(key);

  Future<void> clear() async => _box?.clear();

  Future<void> writeList(
    String key,
    List<Map<String, dynamic>> items, {
    Duration? ttl,
  }) async {
    await write(key, {'items': items}, ttl: ttl);
  }

  Future<List<Map<String, dynamic>>?> readList(String key) async {
    final map = await read(key);
    if (map == null) return null;
    final items = map['items'];
    if (items is List) {
      return items.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    }
    return null;
  }

  Future<bool> isValid(String key) async => (await read(key)) != null;

  // ── Transfer offline queue ──────────────────────────────────────────────────

  static const _queueBoxName = 'bankx_transfer_queue';

  Box<String>? _queueBox;

  Future<void> openQueueBox() async {
    _queueBox ??= await Hive.openBox<String>(_queueBoxName);
  }

  Future<void> enqueueTransfer(Map<String, dynamic> request) async {
    await openQueueBox();
    final id = request['id'] as String;
    await _queueBox?.put(id, jsonEncode(request));
  }

  Future<List<Map<String, dynamic>>> pendingTransfers() async {
    await openQueueBox();
    final items = <Map<String, dynamic>>[];
    for (final raw in _queueBox?.values ?? <String>[]) {
      items.add(Map<String, dynamic>.from(jsonDecode(raw) as Map));
    }
    items.sort(
      (a, b) => (a['createdAt'] as String).compareTo(b['createdAt'] as String),
    );
    return items;
  }

  Future<void> removeQueuedTransfer(String id) async {
    await openQueueBox();
    await _queueBox?.delete(id);
  }
}

/// Standard cache keys per feature.
abstract final class CacheKeys {
  static const dashboard = 'cache_dashboard';
  static const analytics = 'cache_analytics';
  static const accounts = 'cache_accounts';
  static const transactions = 'cache_transactions';
  static const cards = 'cache_cards';
  static const beneficiaries = 'cache_beneficiaries';
  static const notifications = 'cache_notifications';
  static const profile = 'cache_profile';
  static const qrPayment = 'cache_qr_payment';
  static const settings = 'cache_settings';

  static String account(String id) => 'cache_account_$id';
  static String transaction(String id) => 'cache_transaction_$id';
  static String card(String id) => 'cache_card_$id';
}
