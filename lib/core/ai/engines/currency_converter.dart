import '../datasources/fx_rates_remote_data_source.dart';
import '../models/ai_models.dart';

/// Multi-currency conversion with live-rate support and static fallback.
class CurrencyConverter {
  CurrencyConverter({FxRatesRemoteDataSource? fxRates})
    : _fxRates = fxRates ?? FxRatesRemoteDataSource();

  final FxRatesRemoteDataSource _fxRates;

  static const _metadata = {
    'AED': ('UAE Dirham', 'د.إ'),
    'USD': ('US Dollar', r'$'),
    'EUR': ('Euro', '€'),
    'SAR': ('Saudi Riyal', 'ر.س'),
    'QAR': ('Qatari Riyal', 'ر.ق'),
    'KWD': ('Kuwaiti Dinar', 'د.ك'),
  };

  static const _fallbackRates = {
    'AED': 1.0,
    'USD': 3.6725,
    'EUR': 3.98,
    'SAR': 0.979,
    'QAR': 1.008,
    'KWD': 11.95,
  };

  static final List<SupportedCurrency> _fallbackCurrencies = _metadata.entries
      .map(
        (e) => SupportedCurrency(
          code: e.key,
          name: e.value.$1,
          symbol: e.value.$2,
          rateToAed: _fallbackRates[e.key]!,
        ),
      )
      .toList();

  List<SupportedCurrency> _cached = _fallbackCurrencies;
  DateTime? _lastFetched;

  List<SupportedCurrency> get currencies => _cached;
  DateTime? get lastFetched => _lastFetched;
  bool get hasLiveRates => _lastFetched != null;

  SupportedCurrency? find(String code) {
    try {
      return _cached.firstWhere(
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
    final from = find(fromCode) ?? _cached.first;
    final to = find(toCode) ?? _cached.first;
    final inAed = amount * from.rateToAed;
    return inAed / to.rateToAed;
  }

  Future<List<SupportedCurrency>> fetchLiveRates() async {
    try {
      final live = await _fxRates.fetchRatesToAed();
      _cached = _metadata.entries
          .map((e) {
            final code = e.key;
            final rate = live[code] ?? _fallbackRates[code]!;
            return SupportedCurrency(
              code: code,
              name: e.value.$1,
              symbol: e.value.$2,
              rateToAed: rate,
            );
          })
          .toList();
      _lastFetched = DateTime.now();
      return _cached;
    } catch (_) {
      _cached = _fallbackCurrencies;
      return _cached;
    }
  }
}
