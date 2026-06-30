import '../../features/accounts/presentation/bloc/accounts_state.dart';
import '../../features/cards/presentation/bloc/cards_state.dart';
import '../../features/dashboard/presentation/bloc/dashboard_state.dart';
import '../../features/notifications/presentation/bloc/notifications_state.dart';
import '../../features/payments/presentation/bloc/payments_state.dart';
import '../../features/profile/presentation/bloc/profile_state.dart';
import '../../features/settings/presentation/bloc/settings_state.dart';
import '../../features/transactions/presentation/bloc/transactions_state.dart';
import '../../features/transfer/presentation/bloc/transfer_state.dart';

/// Shared [BlocBuilder.buildWhen] predicates to limit rebuild scope per screen.
abstract final class BlocBuildWhen {
  static bool dashboardHome(DashboardState prev, DashboardState next) =>
      prev.status != next.status ||
      prev.dashboardData != next.dashboardData ||
      prev.errorMessage != next.errorMessage;

  static bool dashboardAnalytics(DashboardState prev, DashboardState next) =>
      prev.analyticsStatus != next.analyticsStatus ||
      prev.analyticsData != next.analyticsData ||
      prev.errorMessage != next.errorMessage;

  static bool cardsList(CardsState prev, CardsState next) =>
      prev.listStatus != next.listStatus ||
      prev.cards != next.cards ||
      prev.errorMessage != next.errorMessage;

  static bool profile(ProfileState prev, ProfileState next) =>
      prev.status != next.status ||
      prev.profileData != next.profileData ||
      prev.errorMessage != next.errorMessage;

  static bool transactionsList(
    TransactionsState prev,
    TransactionsState next,
  ) =>
      prev.listStatus != next.listStatus ||
      prev.transactions != next.transactions ||
      prev.errorMessage != next.errorMessage;

  static bool notificationsList(
    NotificationsState prev,
    NotificationsState next,
  ) =>
      prev.status != next.status ||
      prev.notifications != next.notifications ||
      prev.errorMessage != next.errorMessage;

  static bool transferLoad(TransferState prev, TransferState next) =>
      prev.loadStatus != next.loadStatus ||
      prev.accounts != next.accounts ||
      prev.beneficiaries != next.beneficiaries ||
      prev.errorMessage != next.errorMessage;

  static bool settings(SettingsState prev, SettingsState next) =>
      prev.status != next.status ||
      prev.themeMode != next.themeMode ||
      prev.locale != next.locale ||
      prev.errorMessage != next.errorMessage;

  static bool accounts(AccountsState prev, AccountsState next) =>
      prev.status != next.status ||
      prev.account != next.account ||
      prev.errorMessage != next.errorMessage;

  static bool qrPayment(PaymentsState prev, PaymentsState next) =>
      prev.qrStatus != next.qrStatus ||
      prev.qrPaymentData != next.qrPaymentData ||
      prev.errorMessage != next.errorMessage;

  static bool billPayment(PaymentsState prev, PaymentsState next) =>
      prev.billStatus != next.billStatus ||
      prev.successMessage != next.successMessage ||
      prev.errorMessage != next.errorMessage;
}
