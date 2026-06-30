import 'banking_knowledge_base.dart';
import 'knowledge_chunk.dart';

/// Scored retrieval result from the knowledge base.
class RagMatch {
  const RagMatch({required this.chunk, required this.score});

  final KnowledgeChunk chunk;
  final double score;
}

/// Lightweight keyword RAG retriever — no external embeddings API required.
class RagRetriever {
  const RagRetriever({List<KnowledgeChunk>? corpus})
    : _corpus = corpus ?? BankingKnowledgeBase.chunks;

  final List<KnowledgeChunk> _corpus;

  List<RagMatch> retrieve(
    String query, {
    String locale = 'en',
    int topK = 3,
  }) {
    final tokens = _tokenize(query);
    if (tokens.isEmpty) return [];

    final scored = <RagMatch>[];
    for (final chunk in _corpus) {
      if (!_localeMatches(chunk.locale, locale)) continue;
      final score = _score(tokens, chunk);
      if (score > 0) {
        scored.add(RagMatch(chunk: chunk, score: score));
      }
    }

    scored.sort((a, b) => b.score.compareTo(a.score));
    return scored.take(topK).toList();
  }

  bool _localeMatches(String chunkLocale, String userLocale) {
    if (chunkLocale == 'en' && userLocale.startsWith('ar')) return false;
    if (chunkLocale == 'ar' && !userLocale.startsWith('ar')) return false;
    return true;
  }

  List<String> _tokenize(String text) {
    final lower = text.toLowerCase();
    return lower
        .split(RegExp(r'[^\p{L}\p{N}]+', unicode: true))
        .where((t) => t.length > 2)
        .toList();
  }

  double _score(List<String> queryTokens, KnowledgeChunk chunk) {
    final haystack = '${chunk.title} ${chunk.content} ${chunk.keywords.join(' ')}'
        .toLowerCase();
    var hits = 0.0;
    for (final token in queryTokens) {
      if (haystack.contains(token)) hits += 1;
      for (final kw in chunk.keywords) {
        if (kw.toLowerCase().contains(token) || token.contains(kw.toLowerCase())) {
          hits += 0.5;
        }
      }
    }
    return hits / queryTokens.length;
  }
}
