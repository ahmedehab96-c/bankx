import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/accounts/presentation/bloc/accounts_bloc.dart';
import '../../../features/accounts/presentation/bloc/accounts_event.dart';
import '../../../features/accounts/presentation/pages/account_details_page.dart';
import '../../../features/ai/presentation/bloc/ai_assistant/ai_assistant_bloc.dart';
import '../../../features/ai/presentation/bloc/ai_finance/ai_finance_bloc.dart';
import '../../../features/ai/presentation/pages/ai_assistant_page.dart';
import '../../../features/ai/presentation/pages/budget_page.dart';
import '../../../features/ai/presentation/pages/currency_page.dart';
import '../../../features/ai/presentation/pages/investments_page.dart';
import '../../../features/ai/presentation/pages/receipt_ocr_page.dart';
import '../../../features/ai/presentation/pages/smart_search_page.dart';
import '../../../features/ai/presentation/pages/voice_banking_page.dart';
import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/onboarding_page.dart';
import '../../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../../features/auth/presentation/pages/register_page.dart';
import '../../../features/auth/presentation/pages/splash_page.dart';
import '../../../features/cards/presentation/bloc/cards_bloc.dart';
import '../../../features/cards/presentation/bloc/cards_event.dart';
import '../../../features/cards/presentation/pages/card_details_screen.dart';
import '../../../features/cards/presentation/pages/freeze_card_screen.dart';
import '../../../features/cards/presentation/pages/my_cards_screen.dart';
import '../../../features/dashboard/presentation/pages/analytics_page.dart';
import '../../../features/dashboard/presentation/pages/home_page.dart';
import '../../../features/dashboard/presentation/pages/main_shell_page.dart';
import '../../../features/notifications/presentation/bloc/notifications_bloc.dart';
import '../../../features/notifications/presentation/bloc/notifications_event.dart';
import '../../../features/notifications/presentation/pages/notifications_page.dart';
import '../../../features/payments/presentation/bloc/payments_bloc.dart';
import '../../../features/payments/presentation/bloc/payments_event.dart';
import '../../../features/payments/presentation/pages/bill_payment_page.dart';
import '../../../features/payments/presentation/pages/qr_payment_page.dart';
import '../../../features/profile/presentation/pages/help_support_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/settings/presentation/pages/security_settings_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../../features/transactions/presentation/bloc/transactions_bloc.dart';
import '../../../features/transactions/presentation/bloc/transactions_event.dart';
import '../../../features/transactions/presentation/pages/transaction_details_screen.dart';
import '../../../features/transactions/presentation/pages/transaction_history_screen.dart';
import '../../../features/transfer/presentation/bloc/transfer_bloc.dart';
import '../../../features/transfer/presentation/bloc/transfer_event.dart';
import '../../../features/transfer/presentation/pages/add_beneficiary_page.dart';
import '../../../features/transfer/presentation/pages/beneficiaries_page.dart';
import '../../../features/transfer/presentation/pages/transfer_money_page.dart';
import '../constants/app_routes.dart';
import '../di/injection.dart';

/// Creates the app router with auth-aware redirects.
GoRouter createAppRouter({
  required AuthBloc authBloc,
  required Listenable refreshListenable,
}) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final path = state.matchedLocation;
      final isPublic = AppRoutes.publicRoutes.contains(path);
      final isSplash = path == AppRoutes.splash;
      final isAuthenticated = authBloc.state.isAuthenticated;

      if (isSplash) return null;

      if (!isAuthenticated && !isPublic) {
        return AppRoutes.login;
      }

      if (isAuthenticated && isPublic && path != AppRoutes.splash) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (_, _) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, _) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, _) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (_, _) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (_, _) => const OtpVerificationScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (_, _) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.analytics,
                builder: (_, _) => BlocProvider(
                  create: (_) => getIt<AiFinanceBloc>(),
                  child: const AnalyticsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.myCards,
                builder: (_, _) => const MyCardsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (_, _) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.accountDetails,
        builder: (_, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider(
            create: (_) => getIt<AccountsBloc>()
              ..add(AccountDetailsLoaded(id)),
            child: AccountDetailsScreen(accountId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.transactionDetails,
        builder: (_, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider(
            create: (_) => getIt<TransactionsBloc>()
              ..add(TransactionDetailsLoaded(id)),
            child: TransactionDetailsScreen(transactionId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.transactionHistory,
        builder: (_, _) => BlocProvider(
          create: (_) => getIt<TransactionsBloc>()..add(const TransactionsLoaded()),
          child: const TransactionHistoryScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.transfer,
        builder: (_, _) => BlocProvider(
          create: (_) => getIt<TransferBloc>()..add(const TransferLoaded()),
          child: const TransferMoneyScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.beneficiaries,
        builder: (_, _) => BlocProvider(
          create: (_) => getIt<TransferBloc>()..add(const BeneficiariesLoaded()),
          child: const BeneficiariesScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.addBeneficiary,
        builder: (_, _) => BlocProvider(
          create: (_) => getIt<TransferBloc>(),
          child: const AddBeneficiaryScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.cardDetails,
        builder: (_, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider(
            create: (_) => getIt<CardsBloc>()..add(CardDetailsLoaded(id)),
            child: CardDetailsScreen(cardId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.freezeCard,
        builder: (_, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider(
            create: (_) => getIt<CardsBloc>()..add(CardDetailsLoaded(id)),
            child: FreezeCardScreen(cardId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.qrPayment,
        builder: (_, _) => BlocProvider(
          create: (_) => getIt<PaymentsBloc>()..add(const QrPaymentLoaded()),
          child: const QrPaymentScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.billPayment,
        builder: (_, _) => BlocProvider(
          create: (_) => getIt<PaymentsBloc>(),
          child: const BillPaymentScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (_, _) => BlocProvider(
          create: (_) =>
              getIt<NotificationsBloc>()..add(const NotificationsLoaded()),
          child: const NotificationsScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.security,
        builder: (_, _) => const SecuritySettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (_, _) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.help,
        builder: (_, _) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: AppRoutes.aiAssistant,
        builder: (_, _) => BlocProvider(
          create: (_) => getIt<AiAssistantBloc>(),
          child: const AiAssistantPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.budget,
        builder: (_, _) => BlocProvider(
          create: (_) => getIt<AiFinanceBloc>(),
          child: const BudgetPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.smartSearch,
        builder: (_, _) => BlocProvider(
          create: (_) => getIt<TransactionsBloc>()..add(const TransactionsLoaded()),
          child: const SmartSearchPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.receiptOcr,
        builder: (_, _) => const ReceiptOcrPage(),
      ),
      GoRoute(
        path: AppRoutes.voiceBanking,
        builder: (_, _) => const VoiceBankingPage(),
      ),
      GoRoute(
        path: AppRoutes.currency,
        builder: (_, _) => const CurrencyPage(),
      ),
      GoRoute(
        path: AppRoutes.investments,
        builder: (_, _) => const InvestmentsPage(),
      ),
    ],
  );
}
