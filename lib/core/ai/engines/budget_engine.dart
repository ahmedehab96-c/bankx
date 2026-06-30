import '../../../shared/domain/entities/transaction.dart';
import '../models/ai_models.dart';

/// Budget tracking and overspending prediction engine.
class BudgetEngine {
  const BudgetEngine();

  static const defaultCategories = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Entertainment',
  ];

  List<BudgetPlan> buildDefaultBudgets(
    List<Transaction> transactions, {
    String currency = 'AED',
  }) {
    final expenses = transactions
        .where((t) => t.type == TransactionType.expense)
        .toList();

    return defaultCategories.map((cat) {
      final key = cat.toLowerCase();
      final spent = expenses
          .where((t) => t.category.toLowerCase().contains(key.toLowerCase()))
          .fold<double>(0, (s, t) => s + t.amount);
      final limit = _suggestedLimit(cat, spent);
      return BudgetPlan(
        category: cat,
        monthlyLimit: limit,
        spent: spent,
        currency: currency,
      );
    }).toList();
  }

  double _suggestedLimit(String category, double currentSpent) {
    final base = {
      'Food': 2000.0,
      'Transport': 800.0,
      'Shopping': 1500.0,
      'Bills': 2500.0,
      'Entertainment': 600.0,
    };
    final suggested = base[category] ?? 1000.0;
    return currentSpent > suggested ? currentSpent * 1.1 : suggested;
  }

  List<String> predictOverspending(List<BudgetPlan> budgets) {
    final warnings = <String>[];
    for (final b in budgets) {
      if (b.progress >= 0.9 && !b.isOverBudget) {
        warnings.add(
          '${b.category}: ${(b.progress * 100).toStringAsFixed(0)}% used — '
          'may exceed budget soon.',
        );
      }
      if (b.isOverBudget) {
        warnings.add(
          '${b.category} budget exceeded by '
          '${(b.spent - b.monthlyLimit).toStringAsFixed(0)} ${b.currency}.',
        );
      }
    }
    return warnings;
  }

  List<String> recommendSavings(List<BudgetPlan> budgets) {
    final recs = <String>[];
    for (final b in budgets) {
      if (b.isOverBudget) {
        recs.add('Cut ${b.category} spending by 15% next month.');
      } else if (b.remaining > b.monthlyLimit * 0.3) {
        recs.add(
          'Great job on ${b.category}! Consider moving '
          '${(b.remaining * 0.5).toStringAsFixed(0)} ${b.currency} to savings.',
        );
      }
    }
    if (recs.isEmpty) {
      recs.add('Maintain current spending habits and review budgets monthly.');
    }
    return recs.take(3).toList();
  }
}
