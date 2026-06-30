import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/performance/bloc_build_when.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/spending_chart.dart';
import '../../../../core/widgets/statistics_card.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../../ai/presentation/widgets/analytics_ai_section.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

/// Analytics tab with spending overview.
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  var _analyticsRequested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_analyticsRequested) return;
    _analyticsRequested = true;
    final bloc = context.read<DashboardBloc>();
    if (bloc.state.analyticsData == null) {
      bloc.add(const DashboardAnalyticsLoaded());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: BlocBuildWhen.dashboardAnalytics,
      builder: (context, state) {
        if (state.analyticsStatus == RequestStatus.loading ||
            state.analyticsData == null) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(pinned: true, title: Text(l10n.analytics)),
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        }

        final data = state.analyticsData!;

        return BlocBuilder<DashboardBloc, DashboardState>(
          buildWhen: BlocBuildWhen.dashboardHome,
          builder: (context, dashState) {
            final balance = dashState.dashboardData?.totalBalance ?? 0;

            return CustomScrollView(
              slivers: [
                SliverAppBar(pinned: true, title: Text(l10n.analytics)),
                SliverPadding(
                  padding: EdgeInsets.all(padding),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Text(
                        l10n.spendingAnalytics,
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      RepaintBoundary(
                        child: SpendingChart(
                          weeklySpending: data.weeklySpending,
                          weeklyLabels: data.weeklyLabels,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: StatisticsCard(
                              title: l10n.income,
                              value:
                                  'AED ${data.totalIncome.toStringAsFixed(0)}',
                              icon: Icons.arrow_downward_rounded,
                              color: AppColors.income,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: StatisticsCard(
                              title: l10n.expense,
                              value:
                                  'AED ${data.totalExpense.toStringAsFixed(0)}',
                              icon: Icons.arrow_upward_rounded,
                              color: AppColors.expense,
                            ),
                          ),
                        ],
                      ),
                      AnalyticsAiSection(balance: balance),
                    ]),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
