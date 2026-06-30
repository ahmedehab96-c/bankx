import 'package:equatable/equatable.dart';

abstract class PaymentsEvent extends Equatable {
  const PaymentsEvent();

  @override
  List<Object?> get props => [];
}

class QrPaymentLoaded extends PaymentsEvent {
  const QrPaymentLoaded();
}

class BillPaymentSubmitted extends PaymentsEvent {
  const BillPaymentSubmitted({
    required this.amount,
    required this.billType,
  });

  final double amount;
  final String billType;

  @override
  List<Object?> get props => [amount, billType];
}
