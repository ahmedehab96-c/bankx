import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ai/models/ai_models.dart';
import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/category_spending_chart.dart';
import '../../../../core/widgets/finance_score_card.dart';
import '../../../../shared/bloc/request_status.dart';
import '../bloc/ai_finance/ai_finance_bloc.dart';
import '../bloc/ai_finance/ai_finance_event.dart';
import '../bloc/ai_finance/ai_finance_state.dart';

/// AI spending analysis extension for analytics tab.
class AnalyticsAiSection extends StatefulWidget {
  const AnalyticsAiSection({super.key, this.balance = 0});

  final double balance;

  @override
  State<AnalyticsAiSection> createState() => _AnalyticsAiSectionState();
}

class _AnalyticsAiSectionState extends State<AnalyticsAiSection> {
  @override
  void initState() {
    super.initState();
    context.read<AiFinanceBloc>().add(AiFinanceLoaded(balance: widget.balance));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiFinanceBloc, AiFinanceState>(
      builder: (context, state) {
        if (state.status != RequestStatus.success) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Text(
              'AI Spending Analysis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            if (state.insights != null)
              FinanceScoreCard(
                score: state.insights!.financeScore,
                subtitle: state.insights!.monthlySummary,
              ),
            const SizedBox(height: 16),
            if (state.spendingAnalysis != null)
              CategorySpendingChart(
                categories: state.spendingAnalysis!.categories
                    .map(
                      (SpendingCategory c) =>
                          (name: c.name, amount: c.amount, color: c.color),
                    )
                    .toList(),
              ),
            if (state.prediction != null) ...[
              const SizedBox(height: 16),
              _PredictionCard(prediction: state.prediction!),
            ],
            if (state.spendingAnalysis != null) ...[
              const SizedBox(height: 12),
              ...state.spendingAnalysis!.savingsOpportunities.map(
                (String s) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        size: 16,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(s, style: const TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ActionChip(
                  label: const Text('Budget Planner'),
                  onPressed: () => context.pushBudget(),
                ),
                ActionChip(
                  label: const Text('AI Assistant'),
                  onPressed: () => context.pushAiAssistant(),
                ),
                ActionChip(
                  label: const Text('Smart Search'),
                  onPressed: () => context.pushSmartSearch(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _PredictionCard extends StatelessWidget {
  const _PredictionCard({required this.prediction});
  final ExpensePrediction prediction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Expense Forecast',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'End-of-month balance: ${prediction.endOfMonthBalance.toStringAsFixed(0)} AED',
            ),
            Text(
              'Expected expenses: ${prediction.expectedExpenses.toStringAsFixed(0)} AED',
            ),
            Text(
              'Cash flow: ${prediction.projectedCashFlow.toStringAsFixed(0)} AED',
            ),
          ],
        ),
      ),
    );
  }
}
