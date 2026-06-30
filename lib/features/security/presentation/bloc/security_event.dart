import 'package:equatable/equatable.dart';

abstract class SecurityEvent extends Equatable {
  const SecurityEvent();

  @override
  List<Object?> get props => [];
}

class SecuritySettingsLoaded extends SecurityEvent {
  const SecuritySettingsLoaded();
}

class BiometricToggled extends SecurityEvent {
  const BiometricToggled(this.enabled);

  final bool enabled;

  @override
  List<Object?> get props => [enabled];
}

class TwoFactorToggled extends SecurityEvent {
  const TwoFactorToggled(this.enabled);

  final bool enabled;

  @override
  List<Object?> get props => [enabled];
}
