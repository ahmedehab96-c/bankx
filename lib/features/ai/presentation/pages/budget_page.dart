import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ai/models/ai_models.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/budget_progress_card.dart';
import '../../../../core/widgets/category_spending_chart.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../shared/bloc/request_status.dart';
import '../bloc/ai_finance/ai_finance_bloc.dart';
import '../bloc/ai_finance/ai_finance_event.dart';
import '../bloc/ai_finance/ai_finance_state.dart';

/// Smart budget planner with progress tracking and overspending predictions.
class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key, this.balance = 0});

  final double balance;

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  void initState() {
    super.initState();
    context.read<AiFinanceBloc>().add(AiFinanceLoaded(balance: widget.balance));
  }

  @override
  Widget build(BuildContext context) {
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Smart Budget')),
      body: BlocBuilder<AiFinanceBloc, AiFinanceState>(
        builder: (context, state) {
          if (state.status == RequestStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: EdgeInsets.all(padding),
            children: [
              if (state.overspendingWarnings.isNotEmpty) ...[
                _WarningBanner(warnings: state.overspendingWarnings),
                const SizedBox(height: 16),
              ],
              const SectionHeader(title: 'Monthly Budgets'),
              const SizedBox(height: 8),
              ...state.budgets.map(
                (BudgetPlan b) => BudgetProgressCard(
                  category: b.category,
                  spent: b.spent,
                  limit: b.monthlyLimit,
                  currency: b.currency,
                  onEdit: () => _editBudget(context, b),
                ),
              ),
              if (state.spendingAnalysis != null) ...[
                const SizedBox(height: 24),
                const SectionHeader(title: 'Spending by Category'),
                const SizedBox(height: 12),
                CategorySpendingChart(
                  categories: state.spendingAnalysis!.categories
                      .map(
                        (SpendingCategory c) =>
                            (name: c.name, amount: c.amount, color: c.color),
                      )
                      .toList(),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Future<void> _editBudget(BuildContext context, BudgetPlan budget) async {
    final controller = TextEditingController(
      text: budget.monthlyLimit.toStringAsFixed(0),
    );
    final result = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit ${budget.category} Budget'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Monthly limit (AED)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final v = double.tryParse(controller.text);
              Navigator.pop(ctx, v);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null && context.mounted) {
      context.read<AiFinanceBloc>().add(
        AiBudgetUpdated(budget.copyWith(monthlyLimit: result)),
      );
    }
  }
}

class _WarningBanner extends StatelessWidget {
  const _WarningBanner({required this.warnings});
  final List<String> warnings;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: warnings
            .map(
              (w) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.warning_amber,
                      size: 18,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(w, style: const TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
