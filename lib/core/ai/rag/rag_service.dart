import 'rag_retriever.dart';

/// Formats retrieved knowledge for injection into AI prompts.
class RagService {
  const RagService({RagRetriever? retriever})
    : _retriever = retriever ?? const RagRetriever();

  final RagRetriever _retriever;

  /// Returns bullet snippets for the system prompt, or empty if no match.
  String buildKnowledgeContext(String userMessage, {String locale = 'en'}) {
    final matches = _retriever.retrieve(userMessage, locale: locale);
    if (matches.isEmpty) return '';

    final buffer = StringBuffer('Relevant BankX knowledge:\n');
    for (final match in matches) {
      buffer.writeln('- ${match.chunk.title}: ${match.chunk.content}');
    }
    return buffer.toString().trim();
  }
}
