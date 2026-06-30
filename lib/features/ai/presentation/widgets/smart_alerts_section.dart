import 'package:flutter/material.dart';

import '../../../../core/ai/ai_config.dart';
import '../../../../core/ai/models/ai_models.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/usecases/ai_usecases.dart';
import 'smart_alert_tile.dart';

/// AI-powered alerts shown above the notifications list.
class SmartAlertsSection extends StatefulWidget {
  const SmartAlertsSection({super.key, this.balance = 0});

  final double balance;

  @override
  State<SmartAlertsSection> createState() => _SmartAlertsSectionState();
}

class _SmartAlertsSectionState extends State<SmartAlertsSection> {
  List<SmartAlert> _alerts = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (AiConfig.enabled) _load();
  }

  Future<void> _load() async {
    if (!getIt.isRegistered<GetSmartAlertsUseCase>()) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    final result = await getIt<GetSmartAlertsUseCase>()(widget.balance);
    if (!mounted) return;
    result.fold((_) => setState(() => _loading = false), (alerts) {
      setState(() {
        _loading = false;
        _alerts = alerts.take(5).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!AiConfig.enabled) return const SizedBox.shrink();
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: LinearProgressIndicator(minHeight: 2),
      );
    }
    if (_alerts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
          child: Row(
            children: [
              const Icon(Icons.auto_awesome, size: 18, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              Text(
                'Smart Alerts',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        ..._alerts.map((alert) => SmartAlertTile(alert: alert)),
        const SizedBox(height: 8),
        const Divider(height: 1),
        const SizedBox(height: 8),
      ],
    );
  }
}
