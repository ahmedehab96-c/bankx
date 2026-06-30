import '../../shared/domain/entities/transaction.dart';
import 'models/ai_models.dart';

/// Builds structured context for AI requests from banking data.
class AiContextManager {
  const AiContextManager();

  Map<String, dynamic> buildUserContext({
    String? userName,
    double? totalBalance,
    String currency = 'AED',
    List<Transaction>? recentTransactions,
    SpendingAnalysis? spendingAnalysis,
    List<BudgetPlan>? budgets,
  }) {
    return {
      'user_name': ?userName,
      'total_balance': ?totalBalance,
      'currency': currency,
      if (recentTransactions != null)
        'recent_transactions': recentTransactions
            .take(10)
            .map(
              (t) => {
                'title': t.title,
                'amount': t.amount,
                'type': t.type.name,
                'category': t.category,
                'date': t.date.toIso8601String(),
              },
            )
            .toList(),
      if (spendingAnalysis != null)
        'spending_summary': spendingAnalysis.summary,
      if (budgets != null)
        'budgets': budgets
            .map(
              (b) => {
                'category': b.category,
                'limit': b.monthlyLimit,
                'spent': b.spent,
              },
            )
            .toList(),
      'app_features': [
        'transfer',
        'qr_payment',
        'bill_payment',
        'cards',
        'transactions',
        'budget',
        'analytics',
        'investments',
        'currency_converter',
      ],
    };
  }

  Map<String, dynamic> buildNavigationContext(String currentRoute) => {
    'current_route': currentRoute,
  };
}
