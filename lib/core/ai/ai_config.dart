/// Compile-time AI configuration — never hardcode API keys.
abstract final class AiConfig {
  static const String apiUrl = String.fromEnvironment(
    'BANKX_AI_API_URL',
    defaultValue: '',
  );

  static const String apiKey = String.fromEnvironment(
    'BANKX_AI_API_KEY',
    defaultValue: '',
  );

  static const String provider = String.fromEnvironment(
    'BANKX_AI_PROVIDER',
    defaultValue: 'mock',
  );

  static const bool enabled = bool.fromEnvironment(
    'BANKX_ENABLE_AI',
    defaultValue: true,
  );

  static const int maxTokensPerRequest = int.fromEnvironment(
    'BANKX_AI_MAX_TOKENS',
    defaultValue: 2048,
  );

  static const int cacheTtlMinutes = int.fromEnvironment(
    'BANKX_AI_CACHE_TTL_MINUTES',
    defaultValue: 30,
  );

  static bool get useRemoteProvider =>
      enabled && apiUrl.isNotEmpty && apiKey.isNotEmpty;

  static bool get useMockProvider => !useRemoteProvider;
}
