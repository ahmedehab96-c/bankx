import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Personal finance score indicator (0–100).
class FinanceScoreCard extends StatelessWidget {
  const FinanceScoreCard({super.key, required this.score, this.subtitle});

  final int score;
  final String? subtitle;

  Color get _scoreColor {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _scoreColor.withValues(alpha: 0.15),
            Theme.of(context).cardColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _scoreColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 6,
                  backgroundColor: _scoreColor.withValues(alpha: 0.15),
                  color: _scoreColor,
                ),
                Center(
                  child: Text(
                    '$score',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: _scoreColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Finance Score',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle ?? _defaultSubtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _defaultSubtitle {
    if (score >= 80) return 'Excellent financial health';
    if (score >= 60) return 'Good — room for improvement';
    return 'Needs attention — review budgets';
  }
}
