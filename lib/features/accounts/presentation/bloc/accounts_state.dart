import 'package:equatable/equatable.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../../../shared/domain/entities/account.dart';

class AccountsState extends Equatable {
  const AccountsState({
    this.status = RequestStatus.initial,
    this.account,
    this.errorMessage,
  });

  final RequestStatus status;
  final BankAccount? account;
  final String? errorMessage;

  AccountsState copyWith({
    RequestStatus? status,
    BankAccount? account,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AccountsState(
      status: status ?? this.status,
      account: account ?? this.account,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, account, errorMessage];
}
