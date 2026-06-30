import '../models/ai_models.dart';

/// Multi-currency conversion with live-rate architecture.
class CurrencyConverter {
  const CurrencyConverter();

  static const supported = [
    SupportedCurrency(
      code: 'AED',
      name: 'UAE Dirham',
      symbol: 'د.إ',
      rateToAed: 1.0,
    ),
    SupportedCurrency(
      code: 'USD',
      name: 'US Dollar',
      symbol: '\$',
      rateToAed: 3.6725,
    ),
    SupportedCurrency(code: 'EUR', name: 'Euro', symbol: '€', rateToAed: 3.98),
    SupportedCurrency(
      code: 'SAR',
      name: 'Saudi Riyal',
      symbol: 'ر.س',
      rateToAed: 0.979,
    ),
    SupportedCurrency(
      code: 'QAR',
      name: 'Qatari Riyal',
      symbol: 'ر.ق',
      rateToAed: 1.008,
    ),
    SupportedCurrency(
      code: 'KWD',
      name: 'Kuwaiti Dinar',
      symbol: 'د.ك',
      rateToAed: 11.95,
    ),
  ];

  List<SupportedCurrency> get currencies => supported;

  SupportedCurrency? find(String code) {
    try {
      return supported.firstWhere(
        (c) => c.code.toUpperCase() == code.toUpperCase(),
      );
    } catch (_) {
      return null;
    }
  }

  double convert({
    required double amount,
    required String fromCode,
    required String toCode,
  }) {
    final from = find(fromCode) ?? supported.first;
    final to = find(toCode) ?? supported.first;
    final inAed = amount * from.rateToAed;
    return inAed / to.rateToAed;
  }

  /// Placeholder for live rates API — swap implementation in production.
  Future<List<SupportedCurrency>> fetchLiveRates() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return supported;
  }
}
