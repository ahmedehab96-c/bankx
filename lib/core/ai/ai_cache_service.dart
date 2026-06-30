import '../storage/cache_storage_service.dart';
import 'ai_config.dart';

/// Caches AI responses to reduce API calls and enable offline fallback.
class AiCacheService {
  AiCacheService(this._cache);

  final CacheStorageService _cache;

  Future<String?> get(String key) async {
    final json = await _cache.read('ai_cache_$key');
    return json?['response'] as String?;
  }

  Future<void> put(String key, String response) async {
    await _cache.write('ai_cache_$key', {
      'response': response,
      'cached_at': DateTime.now().toIso8601String(),
    }, ttl: const Duration(minutes: AiConfig.cacheTtlMinutes));
  }

  Future<void> invalidate(String key) => _cache.delete('ai_cache_$key');

  Future<void> clearAll() async {
    // Best-effort: AI cache keys are prefixed
  }

  static String hashKey(String input) => input.hashCode.toRadixString(16);
}
