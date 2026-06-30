import 'package:equatable/equatable.dart';

import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/security_usecases.dart';

class SecurityState extends Equatable {
  const SecurityState({
    this.status = RequestStatus.initial,
    this.settings,
    this.errorMessage,
    this.twoFactorEnabled = false,
  });

  final RequestStatus status;
  final SecuritySettings? settings;
  final String? errorMessage;
  final bool twoFactorEnabled;

  SecurityState copyWith({
    RequestStatus? status,
    SecuritySettings? settings,
    String? errorMessage,
    bool? twoFactorEnabled,
    bool clearError = false,
  }) {
    return SecurityState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
    );
  }

  @override
  List<Object?> get props => [status, settings, errorMessage, twoFactorEnabled];
}
