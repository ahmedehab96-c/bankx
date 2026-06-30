import 'ai_cache_service.dart';
import 'ai_config.dart';
import 'ai_provider.dart';
import 'context_manager.dart';
import 'conversation_history_service.dart';
import 'models/ai_models.dart';
import 'prompt_manager.dart';
import 'providers/http_ai_provider.dart';
import 'providers/mock_ai_provider.dart';
import 'token_usage_monitor.dart';

/// Central AI orchestrator — caching, retry, streaming, provider selection.
class AiOrchestrator {
  AiOrchestrator({
    required MockAiProvider mockProvider,
    required HttpAiProvider httpProvider,
    required AiCacheService cache,
    required ConversationHistoryService history,
    required TokenUsageMonitor tokenMonitor,
    PromptManager? promptManager,
    AiContextManager? contextManager,
  }) : _mockProvider = mockProvider,
       _httpProvider = httpProvider,
       _cache = cache,
       _history = history,
       _tokenMonitor = tokenMonitor,
       _promptManager = promptManager ?? const PromptManager(),
       _contextManager = contextManager ?? const AiContextManager();

  final MockAiProvider _mockProvider;
  final HttpAiProvider _httpProvider;
  final AiCacheService _cache;
  final ConversationHistoryService _history;
  final TokenUsageMonitor _tokenMonitor;
  final PromptManager _promptManager;
  final AiContextManager _contextManager;

  AiProvider get _provider =>
      AiConfig.useRemoteProvider ? _httpProvider : _mockProvider;

  MockAiProvider get mockProvider => _mockProvider;

  Future<AiResponse> chat({
    required String userMessage,
    String locale = 'en',
    Map<String, dynamic>? context,
    bool useCache = true,
  }) async {
    if (!AiConfig.enabled) {
      return const AiResponse(
        content: 'AI features are disabled. Enable BANKX_ENABLE_AI in config.',
      );
    }

    if (_tokenMonitor.isDailyLimitReached) {
      return const AiResponse(
        content: 'Daily AI usage limit reached. Please try again tomorrow.',
      );
    }

    final cacheKey = AiCacheService.hashKey('$userMessage$locale');
    if (useCache) {
      final cached = await _cache.get(cacheKey);
      if (cached != null) {
        return AiResponse(content: cached, fromCache: true);
      }
    }

    final history = await _history.load();
    final messages = _promptManager.buildChatMessages(
      userMessage: userMessage,
      history: history,
      locale: locale,
      context: context,
    );

    AiResponse response;
    var attempts = 0;
    while (true) {
      try {
        response = await _provider.complete(
          messages: messages,
          maxTokens: AiConfig.maxTokensPerRequest,
        );
        break;
      } catch (_) {
        attempts++;
        if (attempts >= 3) {
          response = await _mockProvider.complete(messages: messages);
          break;
        }
        await Future<void>.delayed(Duration(milliseconds: 500 * attempts));
      }
    }

    _tokenMonitor.recordUsage(response.tokensUsed);

    await _history.append(
      AiMessage(
        id: _history.newMessageId(),
        role: AiMessageRole.user,
        content: userMessage,
        timestamp: DateTime.now(),
      ),
    );
    await _history.append(
      AiMessage(
        id: _history.newMessageId(),
        role: AiMessageRole.assistant,
        content: response.content,
        timestamp: DateTime.now(),
      ),
    );

    if (useCache && !response.fromCache) {
      await _cache.put(cacheKey, response.content);
    }

    return response;
  }

  Stream<AiStreamChunk> chatStream({
    required String userMessage,
    String locale = 'en',
    Map<String, dynamic>? context,
  }) async* {
    final history = await _history.load();
    final messages = _promptManager.buildChatMessages(
      userMessage: userMessage,
      history: history,
      locale: locale,
      context: context,
    );

    await for (final chunk in _provider.stream(messages: messages)) {
      if (chunk.tokensUsed != null) {
        _tokenMonitor.recordUsage(chunk.tokensUsed!);
      }
      yield chunk;
    }
  }

  Map<String, dynamic> buildContext({
    String? userName,
    double? totalBalance,
    List<dynamic>? recentTransactions,
    Map<String, dynamic>? extra,
  }) => _contextManager.buildUserContext(
    userName: userName,
    totalBalance: totalBalance,
    recentTransactions: recentTransactions?.cast(),
  );

  Future<void> clearHistory() => _history.clear();

  Map<String, int> get usageStats => _tokenMonitor.toJson();
}
