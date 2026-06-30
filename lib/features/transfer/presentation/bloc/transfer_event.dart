import 'package:equatable/equatable.dart';

abstract class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object?> get props => [];
}

class TransferLoaded extends TransferEvent {
  const TransferLoaded();
}

class BeneficiariesLoaded extends TransferEvent {
  const BeneficiariesLoaded();
}

class TransferSubmitted extends TransferEvent {
  const TransferSubmitted({
    required this.fromAccountId,
    required this.beneficiaryId,
    required this.amount,
    this.note,
  });

  final String fromAccountId;
  final String beneficiaryId;
  final double amount;
  final String? note;

  @override
  List<Object?> get props => [fromAccountId, beneficiaryId, amount, note];
}

class AddBeneficiarySubmitted extends TransferEvent {
  const AddBeneficiarySubmitted({
    required this.name,
    required this.bankName,
    required this.accountNumber,
  });

  final String name;
  final String bankName;
  final String accountNumber;

  @override
  List<Object?> get props => [name, bankName, accountNumber];
}
