import 'package:bankx/features/security/domain/repositories/security_repository.dart';
import 'package:bankx/features/security/domain/usecases/security_usecases.dart';
import 'package:bankx/features/security/presentation/bloc/security_bloc.dart';
import 'package:bankx/features/security/presentation/bloc/security_event.dart';
import 'package:bankx/features/security/presentation/bloc/security_state.dart';
import 'package:bankx/shared/bloc/request_status.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSecurityRepository extends Mock implements SecurityRepository {}

void main() {
  group('SecurityBloc', () {
    late _MockSecurityRepository repository;

    blocTest<SecurityBloc, SecurityState>(
      'emits success when settings load',
      build: () {
        repository = _MockSecurityRepository();
        when(() => repository.isBiometricEnabled()).thenAnswer((_) async => true);
        when(() => repository.canUseBiometrics()).thenAnswer((_) async => true);
        when(() => repository.isDeviceSecure()).thenAnswer((_) async => true);
        when(() => repository.isRooted()).thenAnswer((_) async => false);
        return SecurityBloc(
          loadSecuritySettingsUseCase: LoadSecuritySettingsUseCase(repository),
          toggleBiometricUseCase: ToggleBiometricUseCase(repository),
        );
      },
      act: (bloc) => bloc.add(const SecuritySettingsLoaded()),
      expect: () => [
        isA<SecurityState>().having((s) => s.status, 'status', RequestStatus.loading),
        isA<SecurityState>()
            .having((s) => s.status, 'status', RequestStatus.success)
            .having((s) => s.settings?.biometricEnabled, 'biometric', true),
      ],
    );
  });
}
