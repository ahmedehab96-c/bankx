import '../../../shared/domain/entities/transaction.dart';
import '../models/ai_models.dart';

/// Local spending analysis engine — works offline from transaction history.
class SpendingAnalyzer {
  const SpendingAnalyzer();

  SpendingAnalysis analyze(List<Transaction> transactions) {
    final expenses = transactions
        .where((t) => t.type == TransactionType.expense)
        .toList();

    final categoryTotals = <String, double>{};
    for (final t in expenses) {
      categoryTotals[t.category] = (categoryTotals[t.category] ?? 0) + t.amount;
    }

    final totalSpent = expenses.fold<double>(0, (sum, t) => sum + t.amount);

    final sorted = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final colors = [0xFF5C6BC0, 0xFF26A69A, 0xFFEF5350, 0xFFFFA726, 0xFFAB47BC];
    final categories = <SpendingCategory>[];
    for (var i = 0; i < sorted.length && i < 5; i++) {
      final entry = sorted[i];
      categories.add(
        SpendingCategory(
          name: _formatCategory(entry.key),
          amount: entry.value,
          percentage: totalSpent > 0 ? (entry.value / totalSpent) * 100 : 0,
          color: colors[i % colors.length],
        ),
      );
    }

    final trends = _buildMonthlyTrends(expenses);
    final largest = expenses.isEmpty
        ? null
        : expenses.reduce(
            (Transaction a, Transaction b) => a.amount > b.amount ? a : b,
          );

    final savings = _savingsOpportunities(categories, totalSpent);

    return SpendingAnalysis(
      categories: categories,
      trends: trends,
      largestExpense: largest == null
          ? 'No expenses recorded'
          : '${largest.title} — ${largest.amount.toStringAsFixed(0)} AED',
      totalSpent: totalSpent,
      savingsOpportunities: savings,
      summary: _buildSummary(
        totalSpent,
        sorted.isNotEmpty ? sorted.first.key : '',
      ),
    );
  }

  List<SpendingTrend> _buildMonthlyTrends(List<Transaction> expenses) {
    final now = DateTime.now();
    final trends = <SpendingTrend>[];
    for (var i = 3; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i);
      final label = _monthLabel(month.month);
      final amount = expenses
          .where(
            (t) => t.date.year == month.year && t.date.month == month.month,
          )
          .fold<double>(0, (s, t) => s + t.amount);
      trends.add(SpendingTrend(label: label, amount: amount, changePercent: 0));
    }
    for (var i = 1; i < trends.length; i++) {
      final prev = trends[i - 1].amount;
      final curr = trends[i].amount;
      if (prev > 0) {
        trends[i] = SpendingTrend(
          label: trends[i].label,
          amount: curr,
          changePercent: ((curr - prev) / prev) * 100,
        );
      }
    }
    return trends;
  }

  List<String> _savingsOpportunities(
    List<SpendingCategory> categories,
    double total,
  ) {
    final tips = <String>[];
    if (categories.isNotEmpty && categories.first.percentage > 40) {
      tips.add(
        'Reduce ${_formatCategory(categories.first.name)} spending — '
        'it accounts for ${categories.first.percentage.toStringAsFixed(0)}% of expenses.',
      );
    }
    if (total > 5000) {
      tips.add('Set a monthly budget to track spending against your income.');
    }
    tips.add(
      'Review subscriptions and recurring payments for unused services.',
    );
    if (tips.length < 2) {
      tips.add('Enable smart alerts to get notified of unusual spending.');
    }
    return tips.take(3).toList();
  }

  String _buildSummary(double total, String topCategory) {
    if (total == 0) return 'No spending data available yet.';
    return 'You spent ${total.toStringAsFixed(0)} AED this period. '
        'Top category: ${_formatCategory(topCategory)}.';
  }

  String _formatCategory(String cat) =>
      cat.isEmpty ? 'Other' : cat[0].toUpperCase() + cat.substring(1);

  String _monthLabel(int month) {
    const labels = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return labels[month - 1];
  }
}
