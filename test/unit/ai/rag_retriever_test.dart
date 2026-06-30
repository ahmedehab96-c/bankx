import 'package:bankx/core/ai/rag/rag_retriever.dart';
import 'package:bankx/core/ai/rag/rag_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RagRetriever', () {
    const retriever = RagRetriever();

    test('retrieves transfer limit knowledge for transfer query', () {
      final matches = retriever.retrieve('What is my daily transfer limit?');
      expect(matches, isNotEmpty);
      expect(matches.first.chunk.id, 'transfer_limits');
    });

    test('retrieves Arabic security knowledge', () {
      final matches = retriever.retrieve(
        'هل تطلبون الرقم السري؟',
        locale: 'ar',
      );
      expect(matches, isNotEmpty);
      expect(matches.first.chunk.locale, 'ar');
    });

    test('returns empty for unrelated query', () {
      final matches = retriever.retrieve('weather forecast');
      expect(matches, isEmpty);
    });
  });

  group('RagService', () {
    test('formats knowledge context for prompts', () {
      const service = RagService();
      final context = service.buildKnowledgeContext(
        'How much is the transfer fee?',
      );
      expect(context, contains('Relevant BankX knowledge'));
      expect(context.toLowerCase(), contains('fee'));
    });
  });
}
