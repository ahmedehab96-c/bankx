import 'dart:convert';

import '../models/ai_models.dart';

/// Parses OpenAI-compatible `/chat/completions` JSON and SSE streams.
abstract final class OpenAiResponseParser {
  static AiResponse parseCompletion(Map<String, dynamic> data) {
    final choices = data['choices'] as List<dynamic>? ?? [];
    var content = '';
    if (choices.isNotEmpty) {
      final first = choices.first;
      if (first is Map<String, dynamic>) {
        final message = first['message'];
        if (message is Map<String, dynamic>) {
          content = message['content'] as String? ?? '';
        }
      }
    }
    final usage = data['usage'] as Map<String, dynamic>?;
    final tokens = (usage?['total_tokens'] as num?)?.toInt() ?? 0;
    return AiResponse(content: content, tokensUsed: tokens);
  }

  static String? parseStreamLine(String line) {
    final trimmed = line.trim();
    if (!trimmed.startsWith('data:')) return null;
    final payload = trimmed.substring(5).trim();
    if (payload == '[DONE]') return null;
    try {
      final json = jsonDecode(payload);
      if (json is! Map<String, dynamic>) return null;
      final choices = json['choices'] as List<dynamic>? ?? [];
      if (choices.isEmpty) return null;
      final first = choices.first;
      if (first is! Map<String, dynamic>) return null;
      final delta = first['delta'];
      if (delta is! Map<String, dynamic>) return null;
      return delta['content'] as String?;
    } catch (_) {
      return null;
    }
  }
}
