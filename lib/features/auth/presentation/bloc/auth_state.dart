import 'package:equatable/equatable.dart';

import '../../../../shared/bloc/request_status.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = RequestStatus.initial,
    this.isAuthenticated = false,
    this.errorMessage,
    this.successMessage,
  });

  final RequestStatus status;
  final bool isAuthenticated;
  final String? errorMessage;
  final String? successMessage;

  AuthState copyWith({
    RequestStatus? status,
    bool? isAuthenticated,
    String? errorMessage,
    String? successMessage,
    bool clearMessages = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: clearMessages ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearMessages ? null : successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, isAuthenticated, errorMessage, successMessage];
}
