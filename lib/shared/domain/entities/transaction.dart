enum TransactionType { income, expense }

enum TransactionStatus { completed, pending, failed }

/// Transaction model for history and detail screens.
class Transaction {
  const Transaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.currency,
    required this.type,
    required this.status,
    required this.date,
    required this.category,
    required this.icon,
    required this.reference,
    required this.accountId,
  });

  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final String currency;
  final TransactionType type;
  final TransactionStatus status;
  final DateTime date;
  final String category;
  final String icon;
  final String reference;
  final String accountId;
}
