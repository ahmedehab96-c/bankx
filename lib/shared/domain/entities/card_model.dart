enum CardType { virtual, physical }

enum CardStatus { active, frozen }

/// Debit/credit card model.
class BankCard {
  const BankCard({
    required this.id,
    required this.cardNumber,
    required this.holderName,
    required this.expiryDate,
    required this.cvv,
    required this.type,
    required this.status,
    required this.balance,
    required this.currency,
    required this.gradientColors,
  });

  final String id;
  final String cardNumber;
  final String holderName;
  final String expiryDate;
  final String cvv;
  final CardType type;
  final CardStatus status;
  final double balance;
  final String currency;
  final List<int> gradientColors;

  BankCard copyWith({
    CardStatus? status,
  }) {
    return BankCard(
      id: id,
      cardNumber: cardNumber,
      holderName: holderName,
      expiryDate: expiryDate,
      cvv: cvv,
      type: type,
      status: status ?? this.status,
      balance: balance,
      currency: currency,
      gradientColors: gradientColors,
    );
  }
}
