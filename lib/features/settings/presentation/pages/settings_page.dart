import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/performance/bloc_build_when.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/profile_tile.dart';
import '../../../../localization/app_localizations.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/presentation/bloc/settings_event.dart';
import '../../../settings/presentation/bloc/settings_state.dart';

/// App settings for theme and language preferences.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final padding = Responsive.horizontalPadding(context);

    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: BlocBuildWhen.settings,
      builder: (context, settings) {
        return Scaffold(
          appBar: AppBar(title: Text(l10n.settings)),
          body: ListView(
            padding: EdgeInsets.all(padding),
            children: [
              ProfileTile(
                title: l10n.language,
                icon: Icons.language_rounded,
                subtitle: settings.locale.languageCode == 'ar'
                    ? l10n.arabic
                    : l10n.english,
                onTap: () => _showLanguagePicker(context, settings),
              ),
              ProfileTile(
                title: l10n.theme,
                icon: Icons.dark_mode_outlined,
                subtitle: _themeLabel(l10n, settings.themeMode),
                onTap: () => _showThemePicker(context, settings),
                showDivider: false,
              ),
            ],
          ),
        );
      },
    );
  }

  String _themeLabel(AppLocalizations l10n, ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => l10n.lightMode,
      ThemeMode.dark => l10n.darkMode,
      ThemeMode.system => l10n.systemDefault,
    };
  }

  void _showLanguagePicker(BuildContext context, SettingsState settings) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.english),
              trailing: settings.locale.languageCode == 'en'
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                context.read<SettingsBloc>().add(
                  const LocaleChanged(Locale('en')),
                );
                context.pop();
              },
            ),
            ListTile(
              title: Text(l10n.arabic),
              trailing: settings.locale.languageCode == 'ar'
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                context.read<SettingsBloc>().add(
                  const LocaleChanged(Locale('ar')),
                );
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemePicker(BuildContext context, SettingsState settings) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.lightMode),
              onTap: () {
                context.read<SettingsBloc>().add(
                  const ThemeChanged(ThemeMode.light),
                );
                context.pop();
              },
            ),
            ListTile(
              title: Text(l10n.darkMode),
              onTap: () {
                context.read<SettingsBloc>().add(
                  const ThemeChanged(ThemeMode.dark),
                );
                context.pop();
              },
            ),
            ListTile(
              title: Text(l10n.systemDefault),
              onTap: () {
                context.read<SettingsBloc>().add(
                  const ThemeChanged(ThemeMode.system),
                );
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
