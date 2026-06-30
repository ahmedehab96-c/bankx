/// TTL policies for Hive-cached banking data.
abstract final class CachePolicy {
  static const dashboard = Duration(hours: 1);
  static const analytics = Duration(hours: 6);
  static const accounts = Duration(hours: 12);
  static const transactions = Duration(hours: 24);
  static const cards = Duration(hours: 12);
  static const beneficiaries = Duration(hours: 12);
  static const notifications = Duration(minutes: 30);
  static const profile = Duration(hours: 6);
  static const qrPayment = Duration(hours: 1);
  static const settings = Duration(days: 7);

  static Duration forKey(String key) {
    if (key.startsWith('cache_account_')) return accounts;
    if (key.startsWith('cache_transaction_')) return transactions;
    if (key.startsWith('cache_card_')) return cards;
    return switch (key) {
      'cache_dashboard' => dashboard,
      'cache_analytics' => analytics,
      'cache_accounts' => accounts,
      'cache_transactions' => transactions,
      'cache_cards' => cards,
      'cache_beneficiaries' => beneficiaries,
      'cache_notifications' => notifications,
      'cache_profile' => profile,
      'cache_qr_payment' => qrPayment,
      'cache_settings' => settings,
      _ => const Duration(hours: 6),
    };
  }
}
