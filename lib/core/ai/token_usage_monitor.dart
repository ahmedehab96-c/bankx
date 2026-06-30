/// Tracks AI token usage for cost monitoring and rate limiting.
class TokenUsageMonitor {
  TokenUsageMonitor();

  int _sessionTokens = 0;
  int _dailyTokens = 0;
  DateTime _dailyReset = DateTime.now();

  static const int dailyLimit = 50000;

  int get sessionTokens => _sessionTokens;
  int get dailyTokens => _dailyTokens;
  int get remainingDaily => dailyLimit - _dailyTokens;

  bool get isDailyLimitReached => _dailyTokens >= dailyLimit;

  void recordUsage(int tokens) {
    _resetDailyIfNeeded();
    _sessionTokens += tokens;
    _dailyTokens += tokens;
  }

  void resetSession() => _sessionTokens = 0;

  void _resetDailyIfNeeded() {
    final now = DateTime.now();
    if (now.difference(_dailyReset).inHours >= 24) {
      _dailyTokens = 0;
      _dailyReset = now;
    }
  }

  Map<String, int> toJson() => {
    'session': _sessionTokens,
    'daily': _dailyTokens,
    'remaining': remainingDaily,
  };
}
