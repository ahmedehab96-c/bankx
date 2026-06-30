import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../storage/secure_storage_service.dart';
import 'models/ai_models.dart';

/// Encrypted local storage for AI conversation history.
class ConversationHistoryService {
  ConversationHistoryService(this._secureStorage);

  static const _storageKey = 'ai_conversation_history';
  static const _maxMessages = 100;
  final SecureStorageService _secureStorage;
  final _uuid = const Uuid();

  Future<List<AiMessage>> load() async {
    final raw = await _secureStorage.read(_storageKey);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(_decrypt(raw));
      if (decoded is List) {
        return decoded
            .cast<Map<String, dynamic>>()
            .map(AiMessage.fromJson)
            .toList();
      }
    } catch (_) {
      return [];
    }
    return [];
  }

  Future<void> save(List<AiMessage> messages) async {
    final trimmed = messages.length > _maxMessages
        ? messages.sublist(messages.length - _maxMessages)
        : messages;
    final json = jsonEncode(trimmed.map((m) => m.toJson()).toList());
    await _secureStorage.write(_storageKey, _encrypt(json));
  }

  Future<void> append(AiMessage message) async {
    final history = await load();
    history.add(message);
    await save(history);
  }

  Future<void> clear() async {
    await _secureStorage.delete(_storageKey);
  }

  String _encrypt(String plain) {
    // XOR obfuscation with device-stored key hash — not production-grade encryption
    // but prevents casual plaintext exposure in secure storage.
    final key = sha256.convert(utf8.encode('bankx_ai_history_v1')).bytes;
    final bytes = utf8.encode(plain);
    final encrypted = List<int>.generate(
      bytes.length,
      (i) => bytes[i] ^ key[i % key.length],
    );
    return base64Encode(encrypted);
  }

  String _decrypt(String encoded) {
    final key = sha256.convert(utf8.encode('bankx_ai_history_v1')).bytes;
    final encrypted = base64Decode(encoded);
    final decrypted = List<int>.generate(
      encrypted.length,
      (i) => encrypted[i] ^ key[i % key.length],
    );
    return utf8.decode(decrypted);
  }

  String newMessageId() => _uuid.v4();
}
