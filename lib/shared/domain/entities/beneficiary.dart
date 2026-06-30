/// Transfer beneficiary model.
class Beneficiary {
  const Beneficiary({
    required this.id,
    required this.name,
    required this.bankName,
    required this.accountNumber,
    required this.avatarInitials,
    required this.color,
  });

  final String id;
  final String name;
  final String bankName;
  final String accountNumber;
  final String avatarInitials;
  final int color;
}
