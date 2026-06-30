import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Budget progress bar for a single category.
class BudgetProgressCard extends StatelessWidget {
  const BudgetProgressCard({
    super.key,
    required this.category,
    required this.spent,
    required this.limit,
    this.currency = 'AED',
    this.onEdit,
  });

  final String category;
  final double spent;
  final double limit;
  final String currency;
  final VoidCallback? onEdit;

  double get progress => limit > 0 ? (spent / limit).clamp(0, 1.5) : 0;
  bool get isOver => spent > limit;

  @override
  Widget build(BuildContext context) {
    final color = isOver ? AppColors.error : AppColors.primaryBlue;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    category,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${spent.toStringAsFixed(0)} / ${limit.toStringAsFixed(0)} $currency',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    onPressed: onEdit,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress.clamp(0, 1),
                minHeight: 8,
                backgroundColor: color.withValues(alpha: 0.15),
                color: color,
              ),
            ),
            if (isOver) ...[
              const SizedBox(height: 6),
              Text(
                'Over budget by ${(spent - limit).toStringAsFixed(0)} $currency',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
