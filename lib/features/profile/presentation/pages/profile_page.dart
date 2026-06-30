import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/navigation/app_navigator.dart';
import '../../../../core/performance/bloc_build_when.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/profile_tile.dart';
import '../../../../core/widgets/statistics_card.dart';
import '../../../../localization/app_localizations.dart';
import '../../../../shared/bloc/request_status.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

/// User profile screen with navigation to settings.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _profileRequested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_profileRequested) return;
    _profileRequested = true;
    final bloc = context.read<ProfileBloc>();
    if (bloc.state.status == RequestStatus.initial) {
      bloc.add(const ProfileLoaded());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: BlocBuildWhen.profile,
      builder: (context, state) {
        if (state.status == RequestStatus.loading ||
            state.status == RequestStatus.initial ||
            state.profileData == null) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(pinned: true, title: Text(l10n.profile)),
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          );
        }

        final user = state.profileData!.user;

        return CustomScrollView(
          slivers: [
            SliverAppBar(pinned: true, title: Text(l10n.profile)),
            SliverPadding(
              padding: EdgeInsets.all(padding),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor:
                              AppColors.primaryBlue.withValues(alpha: 0.15),
                          child: Text(
                            user.name[0],
                            style: GoogleFonts.inter(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.name,
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          user.email,
                          style: GoogleFonts.inter(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: StatisticsCard(
                          title: l10n.totalBalance,
                          value: 'AED 188K',
                          icon: Icons.account_balance_wallet_outlined,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: StatisticsCard(
                          title: l10n.cards,
                          value: '${state.profileData!.cardCount}',
                          icon: Icons.credit_card_outlined,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ProfileTile(
                    title: l10n.transfer,
                    icon: Icons.swap_horiz_rounded,
                    onTap: () => context.pushTransfer(),
                  ),
                  ProfileTile(
                    title: l10n.beneficiaries,
                    icon: Icons.people_outline,
                    onTap: () => context.pushBeneficiaries(),
                  ),
                  ProfileTile(
                    title: l10n.settings,
                    icon: Icons.settings_outlined,
                    onTap: () => context.pushSettings(),
                  ),
                  ProfileTile(
                    title: l10n.securitySettings,
                    icon: Icons.shield_outlined,
                    iconColor: AppColors.warning,
                    onTap: () => context.pushSecurity(),
                  ),
                  ProfileTile(
                    title: l10n.notifications,
                    icon: Icons.notifications_outlined,
                    onTap: () => context.pushNotifications(),
                  ),
                  ProfileTile(
                    title: l10n.helpSupport,
                    icon: Icons.help_outline_rounded,
                    onTap: () => context.pushHelp(),
                  ),
                  ProfileTile(
                    title: l10n.logout,
                    icon: Icons.logout_rounded,
                    iconColor: AppColors.error,
                    showDivider: false,
                    onTap: () {
                      context.read<AuthBloc>().add(const AuthLogoutRequested());
                      context.goLogin();
                    },
                  ),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }
}
