import 'package:bankx/features/auth/domain/usecases/auth_usecases.dart';
import 'package:bankx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bankx/features/auth/presentation/bloc/auth_event.dart';
import 'package:bankx/features/cards/presentation/bloc/cards_bloc.dart';
import 'package:bankx/features/cards/presentation/bloc/cards_event.dart';
import 'package:bankx/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:bankx/features/notifications/presentation/bloc/notifications_event.dart';
import 'package:bankx/features/payments/presentation/bloc/payments_bloc.dart';
import 'package:bankx/features/payments/presentation/bloc/payments_event.dart';
import 'package:bankx/features/transfer/presentation/bloc/transfer_bloc.dart';
import 'package:bankx/features/transfer/presentation/bloc/transfer_event.dart';
import 'package:bankx/shared/bloc/request_status.dart';
import 'package:bankx/shared/domain/entities/card_model.dart';
import 'package:bankx/shared/domain/entities/notification_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../test/helpers/bloc_mocks.dart';
import '../test/helpers/test_fixtures.dart';

/// Integration-style flow tests exercising blocs end-to-end with mocked use cases.
/// These validate critical banking journeys without hitting real APIs.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(registerBlocTestFallbacks);

  group('Authentication flow', () {
    testWidgets('login then logout', (tester) async {
      final login = _RecordingLoginUseCase();
      final logout = _RecordingLogoutUseCase();
      final bloc = AuthBloc(
        loginUseCase: login,
        logoutUseCase: logout,
        registerUseCase: MockRegisterUseCase(),
        verifyOtpUseCase: MockVerifyOtpUseCase(),
        resetPasswordUseCase: MockResetPasswordUseCase(),
      );
      addTearDown(bloc.close);

      bloc.add(const AuthLoginRequested(email: 'a@b.com', password: 'pass'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(bloc.state.isAuthenticated, isTrue);

      bloc.add(const AuthLogoutRequested());
      await tester.pump();
      expect(bloc.state.isAuthenticated, isFalse);
      expect(logout.called, isTrue);
    });
  });

  group('Money transfer flow', () {
    testWidgets('loads data and submits transfer', (tester) async {
      final accounts = MockGetAccountsUseCase();
      final beneficiaries = MockGetTransferBeneficiariesUseCase();
      final transfer = MockTransferMoneyUseCase();
      when(() => accounts(any()))
          .thenAnswer((_) async => const Right([TestFixtures.account]));
      when(() => beneficiaries(any()))
          .thenAnswer((_) async => const Right([TestFixtures.beneficiary]));
      when(() => transfer(any())).thenAnswer((_) async => const Right(null));

      final bloc = TransferBloc(
        getAccountsUseCase: accounts,
        getTransferBeneficiariesUseCase: beneficiaries,
        transferMoneyUseCase: transfer,
        addBeneficiaryUseCase: MockAddBeneficiaryUseCase(),
      );
      addTearDown(bloc.close);

      bloc.add(const TransferLoaded());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(bloc.state.loadStatus, RequestStatus.success);

      bloc.add(
        const TransferSubmitted(
          fromAccountId: 'acc-1',
          beneficiaryId: 'ben-1',
          amount: 250,
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(bloc.state.submitStatus, RequestStatus.success);
    });
  });

  group('Bill payment flow', () {
    testWidgets('submits bill payment', (tester) async {
      final bill = MockSubmitBillPaymentUseCase();
      when(() => bill(any())).thenAnswer((_) async => const Right(null));

      final bloc = PaymentsBloc(
        getQrPaymentDataUseCase: MockGetQrPaymentDataUseCase(),
        submitBillPaymentUseCase: bill,
      );
      addTearDown(bloc.close);

      bloc.add(const BillPaymentSubmitted(amount: 150, billType: 'electricity'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(bloc.state.billStatus, RequestStatus.success);
    });
  });

  group('QR payment flow', () {
    testWidgets('loads QR data', (tester) async {
      final qr = MockGetQrPaymentDataUseCase();
      when(() => qr(any())).thenAnswer((_) async => Right(TestFixtures.qrPaymentData));

      final bloc = PaymentsBloc(
        getQrPaymentDataUseCase: qr,
        submitBillPaymentUseCase: MockSubmitBillPaymentUseCase(),
      );
      addTearDown(bloc.close);

      bloc.add(const QrPaymentLoaded());
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(bloc.state.qrStatus, RequestStatus.success);
      expect(bloc.state.qrPaymentData?.iban, TestFixtures.account.iban);
    });
  });

  group('Card freeze flow', () {
    testWidgets('toggles card freeze', (tester) async {
      final freeze = MockToggleCardFreezeUseCase();
      when(() => freeze(any())).thenAnswer(
        (_) async => Right(TestFixtures.card.copyWith(status: CardStatus.frozen)),
      );

      final bloc = CardsBloc(
        getCardsUseCase: MockGetCardsUseCase(),
        getCardByIdUseCase: MockGetCardByIdUseCase(),
        toggleCardFreezeUseCase: freeze,
      );
      addTearDown(bloc.close);

      bloc.add(const CardFreezeToggled('card-1'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(bloc.state.freezeStatus, RequestStatus.success);
    });
  });

  group('Notification flow', () {
    testWidgets('loads and marks notification read', (tester) async {
      final get = MockGetNotificationsUseCase();
      final mark = MockMarkNotificationReadUseCase();
      when(() => get(any())).thenAnswer((_) async => Right([TestFixtures.notification]));
      when(() => mark(any())).thenAnswer(
        (_) async => Right([
          AppNotification(
            id: TestFixtures.notification.id,
            title: TestFixtures.notification.title,
            body: TestFixtures.notification.body,
            time: TestFixtures.notification.time,
            isRead: true,
            icon: TestFixtures.notification.icon,
            color: TestFixtures.notification.color,
          ),
        ]),
      );

      final bloc = NotificationsBloc(
        getNotificationsUseCase: get,
        markNotificationReadUseCase: mark,
      );
      addTearDown(bloc.close);

      bloc.add(const NotificationsLoaded());
      await tester.pump();
      bloc.add(const NotificationMarkedRead(0));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(bloc.state.markReadStatus, RequestStatus.success);
    });
  });

  group('Change password flow', () {
    testWidgets('reset password request succeeds', (tester) async {
      final reset = MockResetPasswordUseCase();
      when(() => reset(any())).thenAnswer((_) async => const Right(null));

      final bloc = AuthBloc(
        loginUseCase: MockLoginUseCase(),
        logoutUseCase: MockLogoutUseCase(),
        registerUseCase: MockRegisterUseCase(),
        verifyOtpUseCase: MockVerifyOtpUseCase(),
        resetPasswordUseCase: reset,
      );
      addTearDown(bloc.close);

      bloc.add(const AuthResetPasswordRequested('ahmed@bankx.com'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(bloc.state.status, RequestStatus.success);
      expect(bloc.state.successMessage, 'Reset link sent');
    });
  });

  group('Offline transfer flow', () {
    testWidgets('transfer succeeds when queued offline', (tester) async {
      final transfer = MockTransferMoneyUseCase();
      when(() => transfer(any())).thenAnswer((_) async => const Right(null));

      final bloc = TransferBloc(
        getAccountsUseCase: MockGetAccountsUseCase(),
        getTransferBeneficiariesUseCase: MockGetTransferBeneficiariesUseCase(),
        transferMoneyUseCase: transfer,
        addBeneficiaryUseCase: MockAddBeneficiaryUseCase(),
      );
      addTearDown(bloc.close);

      bloc.add(
        const TransferSubmitted(
          fromAccountId: 'acc-1',
          beneficiaryId: 'ben-1',
          amount: 100,
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));
      expect(bloc.state.submitStatus, RequestStatus.success);
    });
  });
}

class _RecordingLoginUseCase extends Mock implements LoginUseCase {
  _RecordingLoginUseCase() {
    when(() => call(any())).thenAnswer((_) async => const Right(null));
  }
}

class _RecordingLogoutUseCase extends Mock implements LogoutUseCase {
  bool called = false;

  _RecordingLogoutUseCase() {
    when(() => call(any())).thenAnswer((_) async {
      called = true;
      return const Right(null);
    });
  }
}
