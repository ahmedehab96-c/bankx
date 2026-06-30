import '../../../shared/domain/entities/transaction.dart';
import '../models/ai_models.dart';
import 'expense_predictor.dart';
import 'fraud_detector.dart';
import 'spending_analyzer.dart';

/// Generates intelligent alerts from transaction and security data.
class SmartAlertsEngine {
  const SmartAlertsEngine({
    SpendingAnalyzer? spendingAnalyzer,
    FraudDetector? fraudDetector,
  }) : _spendingAnalyzer = spendingAnalyzer ?? const SpendingAnalyzer(),
       _fraudDetector = fraudDetector ?? const FraudDetector();

  final SpendingAnalyzer _spendingAnalyzer;
  final FraudDetector _fraudDetector;

  List<SmartAlert> generate({
    required List<Transaction> transactions,
    required List<BudgetPlan> budgets,
    int failedLoginCount = 0,
    double currentBalance = 0,
  }) {
    final alerts = <SmartAlert>[];
    final now = DateTime.now();

    // Large transaction alert
    final today = transactions.where(
      (t) =>
          t.date.year == now.year &&
          t.date.month == now.month &&
          t.date.day == now.day,
    );
    for (final t in today) {
      if (t.amount >= 5000 && t.type == TransactionType.expense) {
        alerts.add(
          SmartAlert(
            id: 'large_${t.id}',
            type: SmartAlertType.largeTransaction,
            title: 'Large Transaction',
            body: '${t.title}: ${t.amount.toStringAsFixed(0)} ${t.currency}',
            severity: AlertSeverity.warning,
            createdAt: now,
            actionRoute: '/transaction/${t.id}',
          ),
        );
      }
    }

    // Salary received
    for (final t in today) {
      if (t.type == TransactionType.income && t.amount >= 1000) {
        alerts.add(
          SmartAlert(
            id: 'salary_${t.id}',
            type: SmartAlertType.salaryReceived,
            title: 'Income Received',
            body: '${t.title}: +${t.amount.toStringAsFixed(0)} ${t.currency}',
            severity: AlertSeverity.info,
            createdAt: now,
          ),
        );
      }
    }

    // Budget exceeded
    for (final b in budgets) {
      if (b.isOverBudget) {
        alerts.add(
          SmartAlert(
            id: 'budget_${b.category}',
            type: SmartAlertType.budgetExceeded,
            title: 'Budget Exceeded',
            body:
                '${b.category} budget exceeded by '
                '${(b.spent - b.monthlyLimit).toStringAsFixed(0)} ${b.currency}',
            severity: AlertSeverity.warning,
            createdAt: now,
            actionRoute: '/budget',
          ),
        );
      }
    }

    // Upcoming bills from recurring detection
    final prediction = const ExpensePredictor().predict(
      transactions: transactions,
      currentBalance: currentBalance,
    );
    for (final bill in prediction.recurringPayments) {
      final daysUntil = bill.dueDate.difference(now).inDays;
      if (daysUntil >= 0 && daysUntil <= 7) {
        alerts.add(
          SmartAlert(
            id: 'bill_${bill.name.hashCode}',
            type: SmartAlertType.upcomingBill,
            title: 'Upcoming Bill',
            body:
                '${bill.name} due in $daysUntil days — '
                '${bill.amount.toStringAsFixed(0)} AED',
            severity: AlertSeverity.info,
            createdAt: now,
            actionRoute: '/bill-payment',
          ),
        );
      }
    }

    // Unusual spending
    final analysis = _spendingAnalyzer.analyze(transactions);
    if (analysis.categories.isNotEmpty &&
        analysis.categories.first.percentage > 50) {
      alerts.add(
        SmartAlert(
          id: 'unusual_spending',
          type: SmartAlertType.unusualSpending,
          title: 'Spending Pattern',
          body:
              '${analysis.categories.first.name} is '
              '${analysis.categories.first.percentage.toStringAsFixed(0)}% of spending',
          severity: AlertSeverity.info,
          createdAt: now,
          actionRoute: '/analytics',
        ),
      );
    }

    // Fraud signals
    final fraudSignals = _fraudDetector.analyze(
      failedLoginCount: failedLoginCount,
    );
    alerts.addAll(_fraudDetector.toAlerts(fraudSignals));

    alerts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return alerts;
  }
}
