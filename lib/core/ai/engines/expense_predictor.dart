import '../../../shared/domain/entities/transaction.dart';
import '../models/ai_models.dart';

/// Predicts end-of-month balance and recurring payments from history.
class ExpensePredictor {
  const ExpensePredictor();

  ExpensePrediction predict({
    required List<Transaction> transactions,
    required double currentBalance,
  }) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final dayOfMonth = now.day;
    final daysRemaining = daysInMonth - dayOfMonth;

    final monthExpenses = transactions
        .where(
          (t) =>
              t.type == TransactionType.expense &&
              t.date.year == now.year &&
              t.date.month == now.month,
        )
        .toList();

    final monthIncome = transactions
        .where(
          (t) =>
              t.type == TransactionType.income &&
              t.date.year == now.year &&
              t.date.month == now.month,
        )
        .fold<double>(0, (s, t) => s + t.amount);

    final totalExpenses = monthExpenses.fold<double>(0, (s, t) => s + t.amount);
    final dailyAvg = dayOfMonth > 0 ? totalExpenses / dayOfMonth : 0;
    final projectedExpenses = totalExpenses + (dailyAvg * daysRemaining);
    final endBalance = currentBalance + monthIncome - projectedExpenses;
    final recurring = _detectRecurring(transactions);

    return ExpensePrediction(
      endOfMonthBalance: endBalance,
      expectedExpenses: projectedExpenses,
      projectedCashFlow: monthIncome - projectedExpenses,
      recurringPayments: recurring,
      confidence: transactions.length >= 10 ? 0.85 : 0.6,
    );
  }

  List<RecurringPayment> _detectRecurring(List<Transaction> transactions) {
    final recurring = <RecurringPayment>[];
    final patterns = <String, List<Transaction>>{};

    for (final t in transactions.where(
      (t) => t.type == TransactionType.expense,
    )) {
      patterns.putIfAbsent(t.title.toLowerCase(), () => []).add(t);
    }

    for (final entry in patterns.entries) {
      if (entry.value.length >= 2) {
        final latest = entry.value.reduce(
          (a, b) => a.date.isAfter(b.date) ? a : b,
        );
        final nextDue = DateTime(
          latest.date.year,
          latest.date.month + 1,
          latest.date.day,
        );
        recurring.add(
          RecurringPayment(
            name: latest.title,
            amount: latest.amount,
            dueDate: nextDue,
            category: latest.category,
          ),
        );
      }
    }

    return recurring.take(5).toList();
  }
}
