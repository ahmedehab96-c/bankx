/// Single knowledge document chunk for RAG retrieval.
class KnowledgeChunk {
  const KnowledgeChunk({
    required this.id,
    required this.title,
    required this.content,
    required this.keywords,
    this.locale = 'en',
  });

  final String id;
  final String title;
  final String content;
  final List<String> keywords;
  final String locale;
}
