import 'package:equatable/equatable.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/account.dart';
import '../../../../shared/domain/entities/beneficiary.dart';

class TransferState extends Equatable {
  const TransferState({
    this.loadStatus = RequestStatus.initial,
    this.beneficiariesStatus = RequestStatus.initial,
    this.submitStatus = RequestStatus.initial,
    this.addBeneficiaryStatus = RequestStatus.initial,
    this.accounts = const [],
    this.beneficiaries = const [],
    this.errorMessage,
    this.successMessage,
  });

  final RequestStatus loadStatus;
  final RequestStatus beneficiariesStatus;
  final RequestStatus submitStatus;
  final RequestStatus addBeneficiaryStatus;
  final List<BankAccount> accounts;
  final List<Beneficiary> beneficiaries;
  final String? errorMessage;
  final String? successMessage;

  TransferState copyWith({
    RequestStatus? loadStatus,
    RequestStatus? beneficiariesStatus,
    RequestStatus? submitStatus,
    RequestStatus? addBeneficiaryStatus,
    List<BankAccount>? accounts,
    List<Beneficiary>? beneficiaries,
    String? errorMessage,
    String? successMessage,
    bool clearMessages = false,
  }) {
    return TransferState(
      loadStatus: loadStatus ?? this.loadStatus,
      beneficiariesStatus: beneficiariesStatus ?? this.beneficiariesStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      addBeneficiaryStatus: addBeneficiaryStatus ?? this.addBeneficiaryStatus,
      accounts: accounts ?? this.accounts,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      errorMessage:
          clearMessages ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearMessages ? null : successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        beneficiariesStatus,
        submitStatus,
        addBeneficiaryStatus,
        accounts,
        beneficiaries,
        errorMessage,
        successMessage,
      ];
}
