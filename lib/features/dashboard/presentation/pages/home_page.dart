import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/performance/bloc_build_when.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/balance_card.dart';
import '../../../../core/widgets/banking_card.dart';
import '../../../../core/widgets/promo_banner.dart';
import '../../../../core/widgets/quick_action_button.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/spending_chart.dart';
import '../../../../core/widgets/transaction_tile.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../../ai/presentation/widgets/home_ai_insights_section.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

/// Home dashboard with balance, accounts, quick actions, and analytics.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _balanceVisible = true;
  var _dashboardRequested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_dashboardRequested) return;
    _dashboardRequested = true;
    final bloc = context.read<DashboardBloc>();
    if (bloc.state.status == RequestStatus.initial) {
      bloc.add(const DashboardLoaded());
    }
  }

  String _greeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.goodMorning;
    if (hour < 17) return l10n.goodAfternoon;
    return l10n.goodEvening;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: BlocBuildWhen.dashboardHome,
      builder: (context, state) {
        if (state.status == RequestStatus.loading) {
          return const SafeArea(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.errorMessage != null || state.dashboardData == null) {
          return SafeArea(
            child: Center(
              child: Text(state.errorMessage ?? 'Failed to load dashboard'),
            ),
          );
        }

        final data = state.dashboardData!;

        return SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(padding, 16, padding, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DashboardHeader(
                        greeting: _greeting(l10n),
                        name: data.user.name.split(' ').first,
                        onNotifications: () => context.pushNotifications(),
                      ),
                      const SizedBox(height: 24),
                      BalanceCard(
                        balance: data.totalBalance,
                        currency: 'AED',
                        label: l10n.totalBalance,
                        isVisible: _balanceVisible,
                        onToggleVisibility: () =>
                            setState(() => _balanceVisible = !_balanceVisible),
                      ),
                      const SizedBox(height: 28),
                      SectionHeader(title: l10n.myAccounts),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 160,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.accounts.length,
                          separatorBuilder: (context, index) =>
                          const SizedBox(width: 14),
                          itemBuilder: (_, i) {
                            final acc = data.accounts[i];
                            return BankingCard(
                              compact: true,
                              title: acc.name,
                              subtitle: acc.accountNumber,
                              balance: acc.balance,
                              currency: acc.currency,
                              gradientColors: [
                                Color(acc.color),
                                AppColors.primaryDark,
                              ],
                              onTap: () => context.pushAccountDetails(acc.id),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                      SectionHeader(title: l10n.quickActions),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          QuickActionButton(
                            icon: Icons.swap_horiz_rounded,
                            label: l10n.transfer,
                            color: AppColors.primaryBlue,
                            onTap: () => context.pushTransfer(),
                          ),
                          QuickActionButton(
                            icon: Icons.receipt_long_rounded,
                            label: l10n.payBills,
                            color: AppColors.warning,
                            onTap: () => context.pushBillPayment(),
                          ),
                          QuickActionButton(
                            icon: Icons.qr_code_scanner_rounded,
                            label: l10n.scanQr,
                            color: AppColors.accentCyan,
                            onTap: () => context.pushQrPayment(),
                          ),
                          QuickActionButton(
                            icon: Icons.credit_card_rounded,
                            label: l10n.cards,
                            color: AppColors.success,
                            onTap: () => context.goToCardsTab(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      SectionHeader(
                        title: l10n.spendingAnalytics,
                        actionLabel: l10n.thisWeek,
                      ),
                      const SizedBox(height: 16),
                      RepaintBoundary(
                        child: SpendingChart(
                          weeklySpending: data.weeklySpending,
                          weeklyLabels: data.weeklyLabels,
                        ),
                      ),
                      const SizedBox(height: 28),
                      SectionHeader(
                        title: l10n.recentTransactions,
                        actionLabel: l10n.seeAll,
                        onAction: () => context.pushTransactionHistory(),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) {
                    final tx = data.recentTransactions[i];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: TransactionTile(
                        transaction: tx,
                        onTap: () => context.pushTransactionDetails(tx.id),
                      ),
                    );
                  },
                  childCount: data.recentTransactions.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
                  child: HomeAiInsightsSection(balance: data.totalBalance),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: PromoBanner(
                    title: l10n.promoTitle,
                    description: l10n.promoDesc,
                    actionLabel: l10n.learnMore,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({
    required this.greeting,
    required this.name,
    required this.onNotifications,
  });

  final String greeting;
  final String name;
  final VoidCallback onNotifications;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.15),
          child: Text(
            name[0],
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryBlue,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onNotifications,
          icon: const Badge(
            smallSize: 8,
            child: Icon(Icons.notifications_outlined),
          ),
        ),
        IconButton(
          onPressed: () => context.pushAiAssistant(),
          icon: const Icon(Icons.auto_awesome_outlined),
          tooltip: 'AI Assistant',
        ),
      ],
    );
  }
}
