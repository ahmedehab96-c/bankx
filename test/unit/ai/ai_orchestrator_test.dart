import 'package:bankx/core/ai/ai_cache_service.dart';
import 'package:bankx/core/ai/ai_orchestrator.dart';
import 'package:bankx/core/ai/conversation_history_service.dart';
import 'package:bankx/core/ai/models/ai_models.dart';
import 'package:bankx/core/ai/providers/http_ai_provider.dart';
import 'package:bankx/core/ai/providers/mock_ai_provider.dart';
import 'package:bankx/core/ai/providers/open_ai_provider.dart';
import 'package:bankx/core/ai/token_usage_monitor.dart';
import 'package:bankx/core/storage/cache_storage_service.dart';
import 'package:bankx/core/storage/secure_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheStorageService extends Mock implements CacheStorageService {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  late AiOrchestrator orchestrator;
  late MockAiProvider mockProvider;
  late MockCacheStorageService cacheStorage;
  late MockSecureStorageService secureStorage;
  final cacheStore = <String, Map<String, dynamic>>{};
  final secureStore = <String, String>{};

  setUp(() {
    cacheStorage = MockCacheStorageService();
    secureStorage = MockSecureStorageService();
    cacheStore.clear();
    secureStore.clear();

    when(
      () => cacheStorage.write(any(), any(), ttl: any(named: 'ttl')),
    ).thenAnswer((invocation) async {
      cacheStore[invocation.positionalArguments[0] as String] =
          invocation.positionalArguments[1] as Map<String, dynamic>;
    });
    when(() => cacheStorage.read(any())).thenAnswer((invocation) async {
      return cacheStore[invocation.positionalArguments[0] as String];
    });
    when(() => cacheStorage.delete(any())).thenAnswer((invocation) async {
      cacheStore.remove(invocation.positionalArguments[0] as String);
    });

    when(
      () => secureStorage.write(any(), any()),
    ).thenAnswer((invocation) async {
      secureStore[invocation.positionalArguments[0] as String] =
          invocation.positionalArguments[1] as String;
    });
    when(() => secureStorage.read(any())).thenAnswer((invocation) async {
      return secureStore[invocation.positionalArguments[0] as String];
    });
    when(() => secureStorage.delete(any())).thenAnswer((invocation) async {
      secureStore.remove(invocation.positionalArguments[0] as String);
    });

    mockProvider = MockAiProvider();
    mockProvider.updateContext(balance: 1500, userName: 'Ahmed');
    orchestrator = AiOrchestrator(
      mockProvider: mockProvider,
      httpProvider: HttpAiProvider(),
      openAiProvider: OpenAiProvider(),
      cache: AiCacheService(cacheStorage),
      history: ConversationHistoryService(secureStorage),
      tokenMonitor: TokenUsageMonitor(),
    );
  });

  test('chat returns balance from mock provider', () async {
    final response = await orchestrator.chat(userMessage: 'Show my balance');
    expect(response.content, contains('1500'));
    expect(response.fromCache, isFalse);
  });

  test('chat caches identical queries', () async {
    final first = await orchestrator.chat(userMessage: 'Help with transfer');
    final second = await orchestrator.chat(userMessage: 'Help with transfer');
    expect(first.fromCache, isFalse);
    expect(second.fromCache, isTrue);
  });

  test('chatStream emits assistant content', () async {
    final chunks = <AiStreamChunk>[];
    await for (final chunk in orchestrator.chatStream(
      userMessage: 'Analyze spending',
    )) {
      chunks.add(chunk);
    }
    expect(chunks.any((c) => c.delta.isNotEmpty), isTrue);
    expect(chunks.last.isDone, isTrue);
  });

  test('clearHistory removes stored messages', () async {
    await orchestrator.chat(userMessage: 'Hello');
    await orchestrator.clearHistory();
    expect(secureStore.containsKey('ai_conversation_history'), isFalse);
  });
}
