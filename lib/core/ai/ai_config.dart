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

  static const String fxApiUrl = String.fromEnvironment(
    'BANKX_FX_API_URL',
    defaultValue: 'https://open.er-api.com/v6/latest/AED',
  );

  static const String model = String.fromEnvironment(
    'BANKX_AI_MODEL',
    defaultValue: 'gpt-4o-mini',
  );

  static const bool certPinningEnabled = bool.fromEnvironment(
    'BANKX_AI_CERT_PIN_ENABLED',
    defaultValue: false,
  );

  /// Comma-separated SHA-256 hex fingerprints of the AI API certificate.
  static const String certPins = String.fromEnvironment(
    'BANKX_AI_CERT_PINS',
    defaultValue: '',
  );

  static const bool ragEnabled = bool.fromEnvironment(
    'BANKX_AI_RAG_ENABLED',
    defaultValue: true,
  );

  static bool get useOpenAiProvider =>
      enabled && provider.toLowerCase() == 'openai' && apiKey.isNotEmpty;

  static bool get useCustomHttpProvider =>
      enabled && apiUrl.isNotEmpty && apiKey.isNotEmpty && !useOpenAiProvider;

  static bool get useRemoteProvider => useOpenAiProvider || useCustomHttpProvider;

  static bool get useMockProvider => !useRemoteProvider;
}
