import 'models/ai_models.dart';

/// Abstraction for pluggable AI providers (OpenAI, Gemini, Claude, custom backend).
abstract class AiProvider {
  String get name;

  Future<AiResponse> complete({
    required List<AiMessage> messages,
    int maxTokens = 1024,
  });

  Stream<AiStreamChunk> stream({
    required List<AiMessage> messages,
    int maxTokens = 1024,
  });

  Future<bool> isAvailable();
}
