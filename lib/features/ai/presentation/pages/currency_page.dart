import 'package:flutter/material.dart';

import '../../../../core/ai/engines/currency_converter.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/usecases/ai_usecases.dart';

/// Multi-currency converter with live-rate architecture.
class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final _amountController = TextEditingController(text: '1000');
  String _from = 'AED';
  String _to = 'USD';
  double _result = 0;
  List<({String code, String name, String symbol, double rate})> _currencies =
      [];
  bool _liveRates = false;

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }

  Future<void> _loadCurrencies() async {
    final useCase = getIt<GetCurrenciesUseCase>();
    final result = await useCase(const NoParams());
    final converter = getIt<CurrencyConverter>();
    result.fold((_) {}, (list) {
      setState(() {
        _liveRates = converter.hasLiveRates;
        _currencies = list
            .map(
              (c) => (
                code: c.code,
                name: c.name,
                symbol: c.symbol,
                rate: c.rateToAed,
              ),
            )
            .toList();
      });
      _convert();
    });
  }

  Future<void> _convert() async {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final useCase = getIt<ConvertCurrencyUseCase>();
    final result = await useCase(
      ConvertCurrencyParams(amount: amount, from: _from, to: _to),
    );
    result.fold((_) {}, (v) => setState(() => _result = v));
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        actions: [
          if (_liveRates)
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Chip(
                label: Text('Live rates'),
                avatar: Icon(Icons.wifi, size: 16),
              ),
            ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(padding),
        children: [
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => _convert(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _CurrencyDropdown(
                  value: _from,
                  currencies: _currencies,
                  onChanged: (v) {
                    setState(() => _from = v!);
                    _convert();
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.swap_horiz),
              ),
              Expanded(
                child: _CurrencyDropdown(
                  value: _to,
                  currencies: _currencies,
                  onChanged: (v) {
                    setState(() => _to = v!);
                    _convert();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              '${_result.toStringAsFixed(2)} $_to',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Supported: AED, USD, EUR, SAR, QAR, KWD',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CurrencyDropdown extends StatelessWidget {
  const _CurrencyDropdown({
    required this.value,
    required this.currencies,
    required this.onChanged,
  });

  final String value;
  final List<({String code, String name, String symbol, double rate})>
  currencies;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      items: currencies
          .map(
            (c) => DropdownMenuItem(
              value: c.code,
              child: Text('${c.code} (${c.symbol})'),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
