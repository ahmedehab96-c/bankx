import 'dart:convert';

import 'package:dio/dio.dart';

import '../ai_config.dart';
import '../ai_provider.dart';
import '../models/ai_models.dart';
import '../security/ai_dio_factory.dart';
import 'openai_response_parser.dart';

/// Direct OpenAI API provider — uses BANKX_AI_API_KEY and BANKX_AI_MODEL.
class OpenAiProvider implements AiProvider {
  OpenAiProvider({Dio? dio})
    : _dio =
          dio ??
          AiDioFactory.create(
            baseUrl: 'https://api.openai.com/v1',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${AiConfig.apiKey}',
            },
          );

  final Dio _dio;

  @override
  String get name => 'openai';

  @override
  Future<bool> isAvailable() async {
    if (!AiConfig.useOpenAiProvider) return false;
    try {
      await _dio.get<void>('/models', queryParameters: {'limit': 1});
      return true;
    } catch (_) {
      return AiConfig.apiKey.isNotEmpty;
    }
  }

  Map<String, dynamic> _requestBody({
    required List<AiMessage> messages,
    required int maxTokens,
    required bool stream,
  }) => {
    'model': AiConfig.model,
    'messages': messages
        .map((m) => {'role': m.role.name, 'content': m.content})
        .toList(),
    'max_tokens': maxTokens.clamp(1, AiConfig.maxTokensPerRequest),
    'stream': stream,
  };

  @override
  Future<AiResponse> complete({
    required List<AiMessage> messages,
    int maxTokens = 1024,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/chat/completions',
      data: _requestBody(
        messages: messages,
        maxTokens: maxTokens,
        stream: false,
      ),
    );
    return OpenAiResponseParser.parseCompletion(response.data ?? {});
  }

  @override
  Stream<AiStreamChunk> stream({
    required List<AiMessage> messages,
    int maxTokens = 1024,
  }) async* {
    final response = await _dio.post<ResponseBody>(
      '/chat/completions',
      data: _requestBody(
        messages: messages,
        maxTokens: maxTokens,
        stream: true,
      ),
      options: Options(responseType: ResponseType.stream),
    );

    final byteStream = response.data?.stream;
    if (byteStream == null) {
      final full = await complete(messages: messages, maxTokens: maxTokens);
      yield AiStreamChunk(delta: full.content, isDone: true);
      return;
    }

    final buffer = StringBuffer();
    await for (final chunk in byteStream) {
      final text = utf8.decode(chunk, allowMalformed: true);
      buffer.write(text);
      final lines = buffer.toString().split('\n');
      buffer.clear();
      if (lines.isNotEmpty && !text.endsWith('\n')) {
        buffer.write(lines.removeLast());
      }
      for (final line in lines) {
        if (line.trim() == 'data: [DONE]') {
          yield const AiStreamChunk(delta: '', isDone: true);
          return;
        }
        final delta = OpenAiResponseParser.parseStreamLine(line);
        if (delta != null && delta.isNotEmpty) {
          yield AiStreamChunk(delta: delta);
        }
      }
    }
    yield const AiStreamChunk(delta: '', isDone: true);
  }
}
