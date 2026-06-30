import 'package:bankx/core/errors/failures.dart';
import 'package:bankx/core/utils/usecase.dart';
import 'package:bankx/features/accounts/domain/usecases/accounts_usecases.dart';
import 'package:bankx/features/auth/domain/usecases/auth_usecases.dart';
import 'package:bankx/features/cards/domain/usecases/cards_usecases.dart';
import 'package:bankx/features/dashboard/domain/usecases/dashboard_usecases.dart';
import 'package:bankx/features/notifications/domain/usecases/notifications_usecases.dart';
import 'package:bankx/features/payments/domain/usecases/payments_usecases.dart';
import 'package:bankx/features/profile/domain/usecases/profile_usecases.dart';
import 'package:bankx/features/security/domain/usecases/security_usecases.dart';
import 'package:bankx/features/settings/domain/usecases/settings_usecases.dart';
import 'package:bankx/features/transactions/domain/usecases/transactions_usecases.dart';
import 'package:bankx/features/transfer/domain/usecases/transfer_usecases.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

/// Mock use cases for bloc tests — keeps bloc tests decoupled from repositories.
class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}
class MockRegisterUseCase extends Mock implements RegisterUseCase {}
class MockVerifyOtpUseCase extends Mock implements VerifyOtpUseCase {}
class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}
class MockCheckAuthUseCase extends Mock implements CheckAuthUseCase {}

class MockGetDashboardDataUseCase extends Mock implements GetDashboardDataUseCase {}
class MockGetAnalyticsDataUseCase extends Mock implements GetAnalyticsDataUseCase {}

class MockGetAccountByIdUseCase extends Mock implements GetAccountByIdUseCase {}

class MockGetTransactionsUseCase extends Mock implements GetTransactionsUseCase {}
class MockGetTransactionByIdUseCase extends Mock implements GetTransactionByIdUseCase {}

class MockGetAccountsUseCase extends Mock implements GetAccountsUseCase {}
class MockGetTransferBeneficiariesUseCase extends Mock implements GetTransferBeneficiariesUseCase {}
class MockTransferMoneyUseCase extends Mock implements TransferMoneyUseCase {}
class MockAddBeneficiaryUseCase extends Mock implements AddBeneficiaryUseCase {}

class MockGetCardsUseCase extends Mock implements GetCardsUseCase {}
class MockGetCardByIdUseCase extends Mock implements GetCardByIdUseCase {}
class MockToggleCardFreezeUseCase extends Mock implements ToggleCardFreezeUseCase {}

class MockGetQrPaymentDataUseCase extends Mock implements GetQrPaymentDataUseCase {}
class MockSubmitBillPaymentUseCase extends Mock implements SubmitBillPaymentUseCase {}

class MockGetNotificationsUseCase extends Mock implements GetNotificationsUseCase {}
class MockMarkNotificationReadUseCase extends Mock implements MarkNotificationReadUseCase {}

class MockGetProfileDataUseCase extends Mock implements GetProfileDataUseCase {}

class MockGetSettingsUseCase extends Mock implements GetSettingsUseCase {}
class MockSetThemeModeUseCase extends Mock implements SetThemeModeUseCase {}
class MockSetLocaleUseCase extends Mock implements SetLocaleUseCase {}

class MockLoadSecuritySettingsUseCase extends Mock implements LoadSecuritySettingsUseCase {}
class MockToggleBiometricUseCase extends Mock implements ToggleBiometricUseCase {}

/// Canonical failure fixtures for bloc failure-scenario tests.
abstract final class FailureFixtures {
  static const network = NetworkFailure();
  static const unauthorized = UnauthorizedFailure();
  static const timeout = TimeoutFailure();
  static const server = ServerFailure();
  static const empty = EmptyFailure();
  static const validation = ValidationFailure('Invalid input');
  static const unknown = UnknownFailure('Unexpected error');
}

void registerBlocTestFallbacks() {
  registerFallbackValue(const LoginParams(email: '', password: ''));
  registerFallbackValue(const RegisterParams(name: '', email: '', password: ''));
  registerFallbackValue(const VerifyOtpParams(code: ''));
  registerFallbackValue(const ResetPasswordParams(email: ''));
  registerFallbackValue(const NoParams());
  registerFallbackValue(const GetAccountByIdParams(''));
  registerFallbackValue(const GetTransactionsParams());
  registerFallbackValue(const GetTransactionByIdParams(''));
  registerFallbackValue(
    const TransferMoneyParams(
      fromAccountId: '',
      beneficiaryId: '',
      amount: 0,
    ),
  );
  registerFallbackValue(
    const AddBeneficiaryParams(name: '', bankName: '', accountNumber: ''),
  );
  registerFallbackValue(const GetCardByIdParams(''));
  registerFallbackValue(const ToggleCardFreezeParams(''));
  registerFallbackValue(const SubmitBillPaymentParams(amount: 0, billType: ''));
  registerFallbackValue(const MarkNotificationReadParams(0));
  registerFallbackValue(const SetThemeModeParams(ThemeMode.light));
  registerFallbackValue(const SetLocaleParams(Locale('en')));
}
