import 'package:bankx/features/accounts/presentation/bloc/accounts_bloc.dart';
import 'package:bankx/features/accounts/presentation/bloc/accounts_event.dart';
import 'package:bankx/features/accounts/presentation/bloc/accounts_state.dart';
import 'package:bankx/features/cards/presentation/bloc/cards_bloc.dart';
import 'package:bankx/features/cards/presentation/bloc/cards_event.dart';
import 'package:bankx/features/cards/presentation/bloc/cards_state.dart';
import 'package:bankx/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:bankx/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:bankx/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:bankx/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:bankx/features/notifications/presentation/bloc/notifications_event.dart';
import 'package:bankx/features/notifications/presentation/bloc/notifications_state.dart';
import 'package:bankx/features/payments/presentation/bloc/payments_bloc.dart';
import 'package:bankx/features/payments/presentation/bloc/payments_event.dart';
import 'package:bankx/features/payments/presentation/bloc/payments_state.dart';
import 'package:bankx/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bankx/features/profile/presentation/bloc/profile_event.dart';
import 'package:bankx/features/profile/presentation/bloc/profile_state.dart';
import 'package:bankx/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:bankx/features/settings/presentation/bloc/settings_event.dart';
import 'package:bankx/features/settings/presentation/bloc/settings_state.dart';
import 'package:bankx/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:bankx/features/transactions/presentation/bloc/transactions_event.dart';
import 'package:bankx/features/transactions/presentation/bloc/transactions_state.dart';
import 'package:bankx/features/transfer/presentation/bloc/transfer_bloc.dart';
import 'package:bankx/features/transfer/presentation/bloc/transfer_event.dart';
import 'package:bankx/features/transfer/presentation/bloc/transfer_state.dart';
import 'package:bankx/shared/bloc/request_status.dart';
import 'package:bankx/shared/domain/entities/card_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/bloc_mocks.dart';
import '../helpers/result_helpers.dart';
import '../helpers/test_fixtures.dart';

void main() {
  setUpAll(registerBlocTestFallbacks);

  group('DashboardBloc', () {
    late MockGetDashboardDataUseCase dashboardUseCase;
    late MockGetAnalyticsDataUseCase analyticsUseCase;

    setUp(() {
      dashboardUseCase = MockGetDashboardDataUseCase();
      analyticsUseCase = MockGetAnalyticsDataUseCase();
    });

    DashboardBloc build() => DashboardBloc(
          getDashboardDataUseCase: dashboardUseCase,
          getAnalyticsDataUseCase: analyticsUseCase,
        );

    blocTest<DashboardBloc, DashboardState>(
      'loads dashboard successfully',
      build: () {
        when(() => dashboardUseCase(any()))
            .thenAnswer((_) async => Right(TestFixtures.dashboardData));
        return build();
      },
      act: (bloc) => bloc.add(const DashboardLoaded()),
      expect: () => [
        isA<DashboardState>().having((s) => s.status, 'status', RequestStatus.loading),
        isA<DashboardState>()
            .having((s) => s.status, 'status', RequestStatus.success)
            .having((s) => s.dashboardData?.totalBalance, 'balance', 25000),
      ],
    );

    blocTest<DashboardBloc, DashboardState>(
      'emits failure when offline',
      build: () {
        when(() => dashboardUseCase(any()))
            .thenAnswer((_) async => futureLeft(FailureFixtures.network));
        return build();
      },
      act: (bloc) => bloc.add(const DashboardLoaded()),
      expect: () => [
        isA<DashboardState>().having((s) => s.status, 'status', RequestStatus.loading),
        isA<DashboardState>().having((s) => s.errorMessage, 'error', FailureFixtures.network.message),
      ],
    );
  });

  group('AccountsBloc', () {
    blocTest<AccountsBloc, AccountsState>(
      'loads account details',
      build: () {
        final useCase = MockGetAccountByIdUseCase();
        when(() => useCase(any())).thenAnswer((_) async => const Right(TestFixtures.account));
        return AccountsBloc(getAccountByIdUseCase: useCase);
      },
      act: (bloc) => bloc.add(const AccountDetailsLoaded('acc-1')),
      expect: () => [
        isA<AccountsState>().having((s) => s.status, 'status', RequestStatus.loading),
        isA<AccountsState>()
            .having((s) => s.status, 'status', RequestStatus.success)
            .having((s) => s.account?.id, 'id', 'acc-1'),
      ],
    );
  });

  group('TransactionsBloc', () {
    blocTest<TransactionsBloc, TransactionsState>(
      'loads transactions list',
      build: () {
        final list = MockGetTransactionsUseCase();
        final details = MockGetTransactionByIdUseCase();
        when(() => list(any())).thenAnswer((_) async => Right([TestFixtures.transaction]));
        return TransactionsBloc(
          getTransactionsUseCase: list,
          getTransactionByIdUseCase: details,
        );
      },
      act: (bloc) => bloc.add(const TransactionsLoaded()),
      expect: () => [
        isA<TransactionsState>().having((s) => s.listStatus, 'status', RequestStatus.loading),
        isA<TransactionsState>().having((s) => s.transactions.length, 'count', 1),
      ],
    );
  });

  group('TransferBloc', () {
    late MockGetAccountsUseCase accounts;
    late MockGetTransferBeneficiariesUseCase beneficiaries;
    late MockTransferMoneyUseCase transfer;
    late MockAddBeneficiaryUseCase addBeneficiary;

    setUp(() {
      accounts = MockGetAccountsUseCase();
      beneficiaries = MockGetTransferBeneficiariesUseCase();
      transfer = MockTransferMoneyUseCase();
      addBeneficiary = MockAddBeneficiaryUseCase();
    });

    TransferBloc build() => TransferBloc(
          getAccountsUseCase: accounts,
          getTransferBeneficiariesUseCase: beneficiaries,
          transferMoneyUseCase: transfer,
          addBeneficiaryUseCase: addBeneficiary,
        );

    blocTest<TransferBloc, TransferState>(
      'loads accounts and beneficiaries',
      build: () {
        when(() => accounts(any()))
            .thenAnswer((_) async => const Right([TestFixtures.account]));
        when(() => beneficiaries(any()))
            .thenAnswer((_) async => const Right([TestFixtures.beneficiary]));
        return build();
      },
      act: (bloc) => bloc.add(const TransferLoaded()),
      expect: () => [
        isA<TransferState>().having((s) => s.loadStatus, 'status', RequestStatus.loading),
        isA<TransferState>()
            .having((s) => s.loadStatus, 'status', RequestStatus.success)
            .having((s) => s.accounts.length, 'accounts', 1),
      ],
    );

    blocTest<TransferBloc, TransferState>(
      'submits transfer successfully',
      build: () {
        when(() => transfer(any())).thenAnswer((_) async => futureRightVoid());
        return build();
      },
      act: (bloc) => bloc.add(
        const TransferSubmitted(
          fromAccountId: 'a1',
          beneficiaryId: 'b1',
          amount: 100,
        ),
      ),
      expect: () => [
        isA<TransferState>().having((s) => s.submitStatus, 'status', RequestStatus.loading),
        isA<TransferState>()
            .having((s) => s.submitStatus, 'status', RequestStatus.success)
            .having((s) => s.successMessage, 'msg', 'Transfer successful'),
      ],
    );
  });

  group('CardsBloc', () {
    blocTest<CardsBloc, CardsState>(
      'freezes card successfully',
      build: () {
        final list = MockGetCardsUseCase();
        final details = MockGetCardByIdUseCase();
        final freeze = MockToggleCardFreezeUseCase();
        when(() => freeze(any())).thenAnswer(
          (_) async => Right(TestFixtures.card.copyWith(status: CardStatus.frozen)),
        );
        return CardsBloc(
          getCardsUseCase: list,
          getCardByIdUseCase: details,
          toggleCardFreezeUseCase: freeze,
        );
      },
      act: (bloc) => bloc.add(const CardFreezeToggled('card-1')),
      expect: () => [
        isA<CardsState>().having((s) => s.freezeStatus, 'status', RequestStatus.loading),
        isA<CardsState>().having((s) => s.freezeStatus, 'status', RequestStatus.success),
      ],
    );
  });

  group('PaymentsBloc', () {
    blocTest<PaymentsBloc, PaymentsState>(
      'loads QR payment data',
      build: () {
        final qr = MockGetQrPaymentDataUseCase();
        final bill = MockSubmitBillPaymentUseCase();
        when(() => qr(any())).thenAnswer((_) async => Right(TestFixtures.qrPaymentData));
        return PaymentsBloc(
          getQrPaymentDataUseCase: qr,
          submitBillPaymentUseCase: bill,
        );
      },
      act: (bloc) => bloc.add(const QrPaymentLoaded()),
      expect: () => [
        isA<PaymentsState>().having((s) => s.qrStatus, 'status', RequestStatus.loading),
        isA<PaymentsState>()
            .having((s) => s.qrStatus, 'status', RequestStatus.success)
            .having((s) => s.qrPaymentData?.iban, 'iban', TestFixtures.account.iban),
      ],
    );

    blocTest<PaymentsBloc, PaymentsState>(
      'bill payment fails when unauthorized',
      build: () {
        final qr = MockGetQrPaymentDataUseCase();
        final bill = MockSubmitBillPaymentUseCase();
        when(() => bill(any()))
            .thenAnswer((_) async => futureLeft(FailureFixtures.unauthorized));
        return PaymentsBloc(
          getQrPaymentDataUseCase: qr,
          submitBillPaymentUseCase: bill,
        );
      },
      act: (bloc) => bloc.add(
        const BillPaymentSubmitted(amount: 100, billType: 'electricity'),
      ),
      expect: () => [
        isA<PaymentsState>().having((s) => s.billStatus, 'status', RequestStatus.loading),
        isA<PaymentsState>().having((s) => s.errorMessage, 'error', FailureFixtures.unauthorized.message),
      ],
    );
  });

  group('NotificationsBloc', () {
    blocTest<NotificationsBloc, NotificationsState>(
      'loads notifications',
      build: () {
        final get = MockGetNotificationsUseCase();
        final mark = MockMarkNotificationReadUseCase();
        when(() => get(any())).thenAnswer((_) async => Right([TestFixtures.notification]));
        return NotificationsBloc(
          getNotificationsUseCase: get,
          markNotificationReadUseCase: mark,
        );
      },
      act: (bloc) => bloc.add(const NotificationsLoaded()),
      expect: () => [
        isA<NotificationsState>().having((s) => s.status, 'status', RequestStatus.loading),
        isA<NotificationsState>().having((s) => s.notifications.length, 'count', 1),
      ],
    );
  });

  group('ProfileBloc', () {
    blocTest<ProfileBloc, ProfileState>(
      'loads profile data',
      build: () {
        final useCase = MockGetProfileDataUseCase();
        when(() => useCase(any())).thenAnswer((_) async => Right(TestFixtures.profileData));
        return ProfileBloc(getProfileDataUseCase: useCase);
      },
      act: (bloc) => bloc.add(const ProfileLoaded()),
      expect: () => [
        isA<ProfileState>().having((s) => s.status, 'status', RequestStatus.loading),
        isA<ProfileState>()
            .having((s) => s.profileData?.user.name, 'name', TestFixtures.user.name),
      ],
    );
  });

  group('SettingsBloc', () {
    blocTest<SettingsBloc, SettingsState>(
      'loads settings',
      build: () {
        final get = MockGetSettingsUseCase();
        final theme = MockSetThemeModeUseCase();
        final locale = MockSetLocaleUseCase();
        when(() => get(any())).thenAnswer((_) async => Right(TestFixtures.settingsBundle));
        return SettingsBloc(
          getSettingsUseCase: get,
          setThemeModeUseCase: theme,
          setLocaleUseCase: locale,
        );
      },
      act: (bloc) => bloc.add(const SettingsLoaded()),
      expect: () => [
        isA<SettingsState>().having((s) => s.status, 'status', RequestStatus.loading),
        isA<SettingsState>()
            .having((s) => s.themeMode, 'theme', ThemeMode.light)
            .having((s) => s.locale.languageCode, 'locale', 'en'),
      ],
    );

    blocTest<SettingsBloc, SettingsState>(
      'changes locale',
      build: () {
        final get = MockGetSettingsUseCase();
        final theme = MockSetThemeModeUseCase();
        final locale = MockSetLocaleUseCase();
        when(() => locale(any())).thenAnswer((_) async => futureRightVoid());
        return SettingsBloc(
          getSettingsUseCase: get,
          setThemeModeUseCase: theme,
          setLocaleUseCase: locale,
        );
      },
      seed: () => const SettingsState(locale: Locale('en')),
      act: (bloc) => bloc.add(const LocaleChanged(Locale('ar'))),
      expect: () => [
        isA<SettingsState>().having((s) => s.status, 'status', RequestStatus.loading),
        isA<SettingsState>().having((s) => s.locale.languageCode, 'locale', 'ar'),
      ],
    );
  });
}
