import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../domain/usecases/security_usecases.dart';
import 'security_event.dart';
import 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc({
    required LoadSecuritySettingsUseCase loadSecuritySettingsUseCase,
    required ToggleBiometricUseCase toggleBiometricUseCase,
  })  : _loadSecuritySettingsUseCase = loadSecuritySettingsUseCase,
        _toggleBiometricUseCase = toggleBiometricUseCase,
        super(const SecurityState()) {
    on<SecuritySettingsLoaded>(_onLoaded);
    on<BiometricToggled>(_onBiometricToggled);
    on<TwoFactorToggled>(_onTwoFactorToggled);
  }

  final LoadSecuritySettingsUseCase _loadSecuritySettingsUseCase;
  final ToggleBiometricUseCase _toggleBiometricUseCase;

  Future<void> _onLoaded(
    SecuritySettingsLoaded event,
    Emitter<SecurityState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, clearError: true));
    final result = await _loadSecuritySettingsUseCase(const NoParams());
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (settings) => emit(
        state.copyWith(
          status: RequestStatus.success,
          settings: settings,
        ),
      ),
    );
  }

  Future<void> _onBiometricToggled(
    BiometricToggled event,
    Emitter<SecurityState> emit,
  ) async {
    final result = await _toggleBiometricUseCase(
      ToggleBiometricParams(event.enabled),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) {
        final current = state.settings;
        if (current != null) {
          emit(
            state.copyWith(
              status: RequestStatus.success,
              settings: SecuritySettings(
                biometricEnabled: event.enabled,
                biometricsAvailable: current.biometricsAvailable,
                deviceSecure: current.deviceSecure,
                isRooted: current.isRooted,
              ),
            ),
          );
        }
      },
    );
  }

  void _onTwoFactorToggled(
    TwoFactorToggled event,
    Emitter<SecurityState> emit,
  ) {
    emit(
      state.copyWith(
        twoFactorEnabled: event.enabled,
        status: RequestStatus.success,
      ),
    );
  }
}
