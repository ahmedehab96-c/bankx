import 'package:flutter/material.dart';

import '../../../../core/ai/models/ai_models.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/usecase.dart';
import '../../domain/usecases/ai_usecases.dart';

/// Investment module — scalable architecture for stocks, gold, crypto, funds.
class InvestmentsPage extends StatefulWidget {
  const InvestmentsPage({super.key});

  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage> {
  List<InvestmentHolding> _holdings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final useCase = getIt<GetInvestmentsUseCase>();
    final result = await useCase(const NoParams());
    result.fold((_) => setState(() => _loading = false), (h) {
      setState(() {
        _holdings = h;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context);
    final total = _holdings.fold<double>(0, (s, h) => s + h.totalValue);

    return Scaffold(
      appBar: AppBar(title: const Text('Investments')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(padding),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Portfolio Value',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ..._holdings.map((h) => _HoldingTile(holding: h)),
                const SizedBox(height: 16),
                Text(
                  'Architecture ready for live market data integration.',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}

class _HoldingTile extends StatelessWidget {
  const _HoldingTile({required this.holding});
  final InvestmentHolding holding;

  IconData get _icon => switch (holding.assetType) {
    InvestmentAssetType.stock => Icons.show_chart,
    InvestmentAssetType.gold => Icons.diamond_outlined,
    InvestmentAssetType.crypto => Icons.currency_bitcoin,
    InvestmentAssetType.mutualFund => Icons.pie_chart_outline,
  };

  @override
  Widget build(BuildContext context) {
    final isUp = holding.changePercent24h >= 0;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.12),
          child: Icon(_icon, color: AppColors.primaryBlue),
        ),
        title: Text(holding.name),
        subtitle: Text('${holding.quantity} × ${holding.symbol}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              holding.totalValue.toStringAsFixed(2),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              '${isUp ? '+' : ''}${holding.changePercent24h.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 12,
                color: isUp ? AppColors.success : AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
