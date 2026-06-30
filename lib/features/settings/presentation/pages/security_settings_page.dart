import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/profile_tile.dart';
import '../../../../localization/app_localizations.dart';
import '../../../security/presentation/bloc/security_bloc.dart';
import '../../../security/presentation/bloc/security_event.dart';
import '../../../security/presentation/bloc/security_state.dart';

/// Security settings with toggles for biometrics and 2FA.
class SecuritySettingsScreen extends StatelessWidget {
  const SecuritySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SecurityBloc>(),
      child: const _SecuritySettingsBody(),
    );
  }
}

class _SecuritySettingsBody extends StatelessWidget {
  const _SecuritySettingsBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.securitySettings)),
      body: BlocBuilder<SecurityBloc, SecurityState>(
        builder: (context, state) {
          final biometric = state.settings?.biometricEnabled ?? false;
          return ListView(
            padding: EdgeInsets.all(padding),
            children: [
              ProfileTile(
                title: l10n.changePassword,
                icon: Icons.lock_outline,
                onTap: () {},
              ),
              ProfileTile(
                title: l10n.biometricLogin,
                icon: Icons.fingerprint_rounded,
                iconColor: AppColors.primaryBlue,
                trailing: Switch(
                  value: biometric,
                  onChanged: state.settings?.biometricsAvailable == true
                      ? (v) => context
                          .read<SecurityBloc>()
                          .add(BiometricToggled(v))
                      : null,
                ),
                showDivider: true,
              ),
              ProfileTile(
                title: l10n.twoFactorAuth,
                icon: Icons.security_rounded,
                iconColor: AppColors.success,
                trailing: Switch(
                  value: state.twoFactorEnabled,
                  onChanged: (v) => context
                      .read<SecurityBloc>()
                      .add(TwoFactorToggled(v)),
                ),
                showDivider: false,
              ),
            ],
          );
        },
      ),
    );
  }
}
