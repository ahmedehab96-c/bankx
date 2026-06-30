import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/domain/entities/transaction.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';

/// Reusable transaction list tile for history and recent activity.
class TransactionTile extends StatelessWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    this.onTap,
  });

  final Transaction transaction;
  final VoidCallback? onTap;

  IconData _iconForCategory(String icon) {
    return switch (icon) {
      'salary' => Icons.account_balance_wallet_outlined,
      'shopping' => Icons.shopping_bag_outlined,
      'bills' => Icons.receipt_long_outlined,
      'transport' => Icons.directions_car_outlined,
      _ => Icons.swap_horiz,
    };
  }

  Color _iconColor(String icon) {
    return switch (icon) {
      'salary' => AppColors.income,
      'shopping' => AppColors.primaryBlue,
      'bills' => AppColors.warning,
      'transport' => AppColors.accentCyan,
      _ => AppColors.primaryBlue,
    };
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final color = _iconColor(transaction.icon);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _iconForCategory(transaction.icon),
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      transaction.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isIncome ? '+' : '-'}${AppFormatters.currency(transaction.amount, symbol: transaction.currency)}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: isIncome ? AppColors.income : AppColors.expense,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppFormatters.timeAgo(transaction.date),
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
