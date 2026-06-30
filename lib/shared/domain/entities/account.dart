/// Bank account model with mock-friendly fields.
class BankAccount {
  const BankAccount({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.iban,
    required this.balance,
    required this.currency,
    required this.type,
    required this.color,
  });

  final String id;
  final String name;
  final String accountNumber;
  final String iban;
  final double balance;
  final String currency;
  final String type;
  final int color;
}
