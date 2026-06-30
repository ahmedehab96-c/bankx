import 'package:flutter/material.dart';

import '../../../../core/ai/models/ai_models.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';

/// Single smart alert row — used in notifications and golden tests.
class SmartAlertTile extends StatelessWidget {
  const SmartAlertTile({super.key, required this.alert});

  final SmartAlert alert;

  Color _severityColor(AlertSeverity severity) => switch (severity) {
    AlertSeverity.critical => Colors.red,
    AlertSeverity.warning => Colors.orange,
    AlertSeverity.info => AppColors.primaryBlue,
  };

  IconData _iconFor(SmartAlertType type) => switch (type) {
    SmartAlertType.budgetExceeded => Icons.savings_outlined,
    SmartAlertType.upcomingBill => Icons.receipt_long_outlined,
    SmartAlertType.largeTransaction => Icons.payments_outlined,
    SmartAlertType.salaryReceived => Icons.account_balance_wallet_outlined,
    SmartAlertType.suspiciousActivity => Icons.shield_outlined,
    SmartAlertType.fraudWarning => Icons.warning_amber_outlined,
    SmartAlertType.unusualSpending => Icons.insights_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final color = _severityColor(alert.severity);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: color.withValues(alpha: 0.06),
      child: ListTile(
        leading: Icon(_iconFor(alert.type), color: color),
        title: Text(
          alert.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(alert.body),
        trailing: alert.actionRoute != null
            ? const Icon(Icons.chevron_right_rounded)
            : null,
        onTap: alert.actionRoute != null
            ? () => context.pushRoute(alert.actionRoute!)
            : null,
      ),
    );
  }
}
