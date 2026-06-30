import 'package:dio/dio.dart';

import '../ai_config.dart';
import '../ai_provider.dart';
import '../models/ai_models.dart';

/// HTTP-based AI provider — connects to any OpenAI-compatible backend.
/// Configure via BANKX_AI_API_URL and BANKX_AI_API_KEY environment variables.
class HttpAiProvider implements AiProvider {
  HttpAiProvider({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: AiConfig.apiUrl,
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 60),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${AiConfig.apiKey}',
              },
            ),
          );

  final Dio _dio;

  @override
  String get name => AiConfig.provider;

  @override
  Future<bool> isAvailable() async {
    if (!AiConfig.useRemoteProvider) return false;
    try {
      await _dio.get<void>('/health');
      return true;
    } catch (_) {
      return true; // Assume available if health endpoint missing
    }
  }

  @override
  Future<AiResponse> complete({
    required List<AiMessage> messages,
    int maxTokens = 1024,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/chat/completions',
      data: {
        'messages': messages
            .map((m) => {'role': m.role.name, 'content': m.content})
            .toList(),
        'max_tokens': maxTokens.clamp(1, AiConfig.maxTokensPerRequest),
        'stream': false,
      },
    );

    final data = response.data ?? {};
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

  @override
  Stream<AiStreamChunk> stream({
    required List<AiMessage> messages,
    int maxTokens = 1024,
  }) async* {
    final response = await _dio.post<ResponseBody>(
      '/chat/completions',
      data: {
        'messages': messages
            .map((m) => {'role': m.role.name, 'content': m.content})
            .toList(),
        'max_tokens': maxTokens,
        'stream': true,
      },
      options: Options(responseType: ResponseType.stream),
    );

    final stream = response.data?.stream;
    if (stream == null) {
      final full = await complete(messages: messages, maxTokens: maxTokens);
      yield AiStreamChunk(delta: full.content, isDone: true);
      return;
    }

    await for (final chunk in stream) {
      final text = String.fromCharCodes(chunk);
      if (text.contains('[DONE]')) {
        yield const AiStreamChunk(delta: '', isDone: true);
        break;
      }
      yield AiStreamChunk(delta: text);
    }
  }
}
