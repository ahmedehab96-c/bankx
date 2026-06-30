import '../../../shared/domain/entities/transaction.dart';
import '../models/ai_models.dart';

/// Natural language transaction search engine.
class SmartSearchEngine {
  const SmartSearchEngine();

  SmartSearchResult search(String query, List<Transaction> transactions) {
    final lower = query.toLowerCase();
    var filtered = transactions.toList();
    var interpretation = 'All transactions';

    // Amount filters
    final amountMatch = RegExp(
      r'(above|over|more than|greater than)\s+(\d+)',
      caseSensitive: false,
    ).firstMatch(lower);
    if (amountMatch != null) {
      final min = double.tryParse(amountMatch.group(2) ?? '') ?? 0;
      filtered = filtered.where((t) => t.amount >= min).toList();
      interpretation = 'Transactions above $min AED';
    }

    final belowMatch = RegExp(
      r'(below|under|less than)\s+(\d+)',
      caseSensitive: false,
    ).firstMatch(lower);
    if (belowMatch != null) {
      final max = double.tryParse(belowMatch.group(2) ?? '') ?? double.infinity;
      filtered = filtered.where((t) => t.amount <= max).toList();
      interpretation = 'Transactions below $max AED';
    }

    // Time filters
    if (lower.contains('last week') || lower.contains('past week')) {
      final cutoff = DateTime.now().subtract(const Duration(days: 7));
      filtered = filtered.where((t) => t.date.isAfter(cutoff)).toList();
      interpretation = 'Transactions from last week';
    }
    if (lower.contains('last month') || lower.contains('past month')) {
      final cutoff = DateTime.now().subtract(const Duration(days: 30));
      filtered = filtered.where((t) => t.date.isAfter(cutoff)).toList();
      interpretation = 'Transactions from last month';
    }
    if (lower.contains('today')) {
      final today = DateTime.now();
      filtered = filtered
          .where(
            (t) =>
                t.date.year == today.year &&
                t.date.month == today.month &&
                t.date.day == today.day,
          )
          .toList();
      interpretation = "Today's transactions";
    }

    // Category / merchant
    final categories = [
      'restaurant',
      'food',
      'transport',
      'shopping',
      'bills',
      'salary',
      'income',
    ];
    for (final cat in categories) {
      if (lower.contains(cat)) {
        filtered = filtered
            .where(
              (t) =>
                  t.category.toLowerCase().contains(cat) ||
                  t.title.toLowerCase().contains(cat),
            )
            .toList();
        interpretation = '${cat[0].toUpperCase()}${cat.substring(1)} expenses';
        break;
      }
    }

    // Arabic keywords
    if (lower.contains('مطعم') || lower.contains('طعام')) {
      filtered = filtered
          .where(
            (t) =>
                t.category.toLowerCase().contains('food') ||
                t.title.toLowerCase().contains('restaurant'),
          )
          .toList();
      interpretation = 'مصاريف المطاعم';
    }

    final total = filtered.fold<double>(0, (s, t) => s + t.amount);

    return SmartSearchResult(
      transactionIds: filtered.map((t) => t.id).toList(),
      interpretation: interpretation,
      totalAmount: total,
    );
  }
}
