import 'package:bankx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bankx/features/auth/presentation/pages/login_page.dart';
import 'package:bankx/features/auth/presentation/pages/register_page.dart';
import 'package:bankx/features/cards/presentation/bloc/cards_bloc.dart';
import 'package:bankx/features/cards/presentation/bloc/cards_state.dart';
import 'package:bankx/features/cards/presentation/pages/my_cards_screen.dart';
import 'package:bankx/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:bankx/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:bankx/features/dashboard/presentation/pages/home_page.dart';
import 'package:bankx/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:bankx/features/notifications/presentation/bloc/notifications_state.dart';
import 'package:bankx/features/notifications/presentation/pages/notifications_page.dart';
import 'package:bankx/features/payments/presentation/bloc/payments_bloc.dart';
import 'package:bankx/features/payments/presentation/bloc/payments_state.dart';
import 'package:bankx/features/payments/presentation/pages/qr_payment_page.dart';
import 'package:bankx/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bankx/features/profile/presentation/bloc/profile_state.dart';
import 'package:bankx/features/profile/presentation/pages/profile_page.dart';
import 'package:bankx/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:bankx/features/settings/presentation/bloc/settings_state.dart';
import 'package:bankx/features/settings/presentation/pages/settings_page.dart';
import 'package:bankx/features/transfer/presentation/bloc/transfer_bloc.dart';
import 'package:bankx/features/transfer/presentation/bloc/transfer_state.dart';
import 'package:bankx/features/transfer/presentation/pages/transfer_money_page.dart';
import 'package:bankx/shared/bloc/request_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/bloc_mocks.dart';
import '../helpers/pump_app.dart';
import '../helpers/test_di.dart';
import '../helpers/test_fixtures.dart';

void main() {
  setUpAll(() async {
    registerBlocTestFallbacks();
    await registerWidgetTestDependencies();
  });

  tearDownAll(() async {
    await tearDownWidgetTestDependencies();
  });

  group('LoginScreen', () {
    testWidgets('renders email and password fields', (tester) async {
      final bloc = AuthBloc(
        loginUseCase: MockLoginUseCase(),
        logoutUseCase: MockLogoutUseCase(),
        registerUseCase: MockRegisterUseCase(),
        verifyOtpUseCase: MockVerifyOtpUseCase(),
        resetPasswordUseCase: MockResetPasswordUseCase(),
      );
      addTearDown(bloc.close);

      await pumpLocalizedWidget(
        tester,
        withBloc(bloc: bloc, child: const LoginScreen()),
      );

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Welcome Back'), findsOneWidget);
    });

    testWidgets('validates short password', (tester) async {
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;

      final bloc = AuthBloc(
        loginUseCase: MockLoginUseCase(),
        logoutUseCase: MockLogoutUseCase(),
        registerUseCase: MockRegisterUseCase(),
        verifyOtpUseCase: MockVerifyOtpUseCase(),
        resetPasswordUseCase: MockResetPasswordUseCase(),
      );
      addTearDown(bloc.close);

      await pumpLocalizedWidget(
        tester,
        withBloc(bloc: bloc, child: const LoginScreen()),
      );

      await tester.enterText(find.byType(TextFormField).at(1), '123');
      await tester.tap(find.text('Sign In'));
      await tester.pump();
      expect(find.text('Min 6 characters'), findsOneWidget);
    });
  });

  group('RegisterScreen', () {
    testWidgets('renders registration form fields', (tester) async {
      await pumpLocalizedWidget(tester, const RegisterScreen());
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.byType(TextFormField), findsWidgets);
    });
  });

  group('HomeScreen', () {
    testWidgets('shows loading indicator when loading', (tester) async {
      final bloc = DashboardBloc(
        getDashboardDataUseCase: MockGetDashboardDataUseCase(),
        getAnalyticsDataUseCase: MockGetAnalyticsDataUseCase(),
      );
      addTearDown(bloc.close);
      bloc.emit(const DashboardState(status: RequestStatus.loading));

      await pumpLocalizedWidget(
        tester,
        withBloc(bloc: bloc, child: const HomeScreen()),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders dashboard when data loaded', (tester) async {
      final bloc = DashboardBloc(
        getDashboardDataUseCase: MockGetDashboardDataUseCase(),
        getAnalyticsDataUseCase: MockGetAnalyticsDataUseCase(),
      );
      addTearDown(bloc.close);
      bloc.emit(
        DashboardState(
          status: RequestStatus.success,
          dashboardData: TestFixtures.dashboardData,
        ),
      );

      await pumpLocalizedWidget(
        tester,
        withBloc(bloc: bloc, child: const HomeScreen()),
      );
      expect(find.textContaining('Ahmed'), findsWidgets);
    });
  });

  group('TransferMoneyScreen', () {
    testWidgets('renders transfer form', (tester) async {
      final bloc = TransferBloc(
        getAccountsUseCase: MockGetAccountsUseCase(),
        getTransferBeneficiariesUseCase: MockGetTransferBeneficiariesUseCase(),
        transferMoneyUseCase: MockTransferMoneyUseCase(),
        addBeneficiaryUseCase: MockAddBeneficiaryUseCase(),
      );
      addTearDown(bloc.close);
      bloc.emit(
        const TransferState(
          loadStatus: RequestStatus.success,
          accounts: [TestFixtures.account],
          beneficiaries: [TestFixtures.beneficiary],
        ),
      );

      await pumpLocalizedWidget(
        tester,
        withBloc(bloc: bloc, child: const TransferMoneyScreen()),
      );
      expect(find.text('Transfer Money'), findsOneWidget);
    });
  });

  group('MyCardsScreen', () {
    testWidgets('renders card list', (tester) async {
      final bloc = CardsBloc(
        getCardsUseCase: MockGetCardsUseCase(),
        getCardByIdUseCase: MockGetCardByIdUseCase(),
        toggleCardFreezeUseCase: MockToggleCardFreezeUseCase(),
      );
      addTearDown(bloc.close);
      bloc.emit(
        const CardsState(
          listStatus: RequestStatus.success,
          cards: [TestFixtures.card],
        ),
      );

      await pumpLocalizedWidget(
        tester,
        withBloc(bloc: bloc, child: const MyCardsScreen()),
      );
      expect(find.text('My Cards'), findsOneWidget);
    });
  });

  group('QrPaymentScreen', () {
    testWidgets('renders QR payment screen', (tester) async {
      final bloc = PaymentsBloc(
        getQrPaymentDataUseCase: MockGetQrPaymentDataUseCase(),
        submitBillPaymentUseCase: MockSubmitBillPaymentUseCase(),
      );
      addTearDown(bloc.close);
      bloc.emit(
        PaymentsState(
          qrStatus: RequestStatus.success,
          qrPaymentData: TestFixtures.qrPaymentData,
        ),
      );

      await pumpLocalizedWidget(
        tester,
        withBloc(bloc: bloc, child: const QrPaymentScreen()),
      );
      expect(find.text('QR Payment'), findsOneWidget);
      expect(find.text('Scan to Pay'), findsOneWidget);
    });
  });

  group('NotificationsScreen', () {
    testWidgets('renders notification list', (tester) async {
      final bloc = NotificationsBloc(
        getNotificationsUseCase: MockGetNotificationsUseCase(),
        markNotificationReadUseCase: MockMarkNotificationReadUseCase(),
      );
      addTearDown(bloc.close);
      bloc.emit(
        NotificationsState(
          status: RequestStatus.success,
          notifications: [TestFixtures.notification],
        ),
      );

      await pumpLocalizedWidget(
        tester,
        withBloc(bloc: bloc, child: const NotificationsScreen()),
      );
      expect(find.text('Transfer received'), findsOneWidget);
    });
  });

  group('ProfileScreen', () {
    testWidgets('renders profile header', (tester) async {
      final profileBloc = ProfileBloc(getProfileDataUseCase: MockGetProfileDataUseCase());
      final authBloc = AuthBloc(
        loginUseCase: MockLoginUseCase(),
        logoutUseCase: MockLogoutUseCase(),
        registerUseCase: MockRegisterUseCase(),
        verifyOtpUseCase: MockVerifyOtpUseCase(),
        resetPasswordUseCase: MockResetPasswordUseCase(),
      );
      addTearDown(profileBloc.close);
      addTearDown(authBloc.close);
      profileBloc.emit(
        ProfileState(
          status: RequestStatus.success,
          profileData: TestFixtures.profileData,
        ),
      );

      await pumpLocalizedWidget(
        tester,
        MultiBlocProvider(
          providers: [
            BlocProvider<ProfileBloc>.value(value: profileBloc),
            BlocProvider<AuthBloc>.value(value: authBloc),
          ],
          child: const Scaffold(body: ProfileScreen()),
        ),
      );
      expect(find.text('Ahmed Mohammed'), findsOneWidget);
    });
  });

  group('SettingsScreen', () {
    testWidgets('renders theme and language options', (tester) async {
      final bloc = SettingsBloc(
        getSettingsUseCase: MockGetSettingsUseCase(),
        setThemeModeUseCase: MockSetThemeModeUseCase(),
        setLocaleUseCase: MockSetLocaleUseCase(),
      );
      addTearDown(bloc.close);
      bloc.emit(
        const SettingsState(
          status: RequestStatus.success,
          themeMode: ThemeMode.light,
          locale: Locale('en'),
        ),
      );

      await pumpLocalizedWidget(
        tester,
        withBloc(bloc: bloc, child: const SettingsScreen()),
      );
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Language'), findsOneWidget);
      expect(find.text('Theme'), findsOneWidget);
    });

    testWidgets('supports Arabic localization', (tester) async {
      final bloc = SettingsBloc(
        getSettingsUseCase: MockGetSettingsUseCase(),
        setThemeModeUseCase: MockSetThemeModeUseCase(),
        setLocaleUseCase: MockSetLocaleUseCase(),
      );
      addTearDown(bloc.close);
      bloc.emit(
        const SettingsState(
          status: RequestStatus.success,
          themeMode: ThemeMode.dark,
          locale: Locale('ar'),
        ),
      );

      await pumpLocalizedWidget(
        tester,
        withBloc(bloc: bloc, child: const SettingsScreen()),
        locale: const Locale('ar'),
        themeMode: ThemeMode.dark,
      );
      expect(find.text('الإعدادات'), findsOneWidget);
    });
  });
}
