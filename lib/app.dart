import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'core/accessibility/accessibility_config.dart';
import 'core/di/injection.dart';
import 'core/firebase/push_notification_service.dart';
import 'core/navigation/app_router.dart';
import 'core/performance/app_appearance.dart';
import 'core/performance/startup_scheduler.dart';
import 'core/security/app_lifecycle_guard.dart';
import 'core/security/session_activity_detector.dart';
import 'core/services/router_refresh_notifier.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/cards/presentation/bloc/cards_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/settings/presentation/bloc/settings_state.dart';
import 'localization/app_localizations.dart';

/// Root BankX application widget.
class BankXApp extends StatefulWidget {
  const BankXApp({super.key});

  @override
  State<BankXApp> createState() => _BankXAppState();
}

class _BankXAppState extends State<BankXApp> {
  late final AuthBloc _authBloc = getIt<AuthBloc>();
  late final SettingsBloc _settingsBloc = getIt<SettingsBloc>();
  late final DashboardBloc _dashboardBloc = getIt<DashboardBloc>();
  late final CardsBloc _cardsBloc = getIt<CardsBloc>();
  late final ProfileBloc _profileBloc = getIt<ProfileBloc>();
  late final RouterRefreshNotifier _refreshNotifier;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _refreshNotifier = RouterRefreshNotifier([_authBloc]);
    _router = createAppRouter(
      authBloc: _authBloc,
      refreshListenable: _refreshNotifier,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<PushNotificationService>().initialize(router: _router);
      StartupScheduler.scheduleDeferredStartup();
    });
  }

  @override
  void dispose() {
    _refreshNotifier.dispose();
    _dashboardBloc.close();
    _cardsBloc.close();
    _profileBloc.close();
    _authBloc.close();
    _settingsBloc.close();
    unawaited(StartupScheduler.shutdown());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider.value(value: _settingsBloc),
        BlocProvider.value(value: _dashboardBloc),
        BlocProvider.value(value: _cardsBloc),
        BlocProvider.value(value: _profileBloc),
      ],
      child: BlocSelector<SettingsBloc, SettingsState, AppAppearance>(
        selector: AppAppearance.from,
        builder: (context, appearance) {
          final accessibility = AccessibilityConfig(
            textScale: appearance.textScale,
            highContrast: appearance.highContrast,
            screenReaderEnabled: appearance.screenReaderEnabled,
          );
          return AccessibilityWrapper(
            config: accessibility,
            child: MaterialApp.router(
              title: 'BankX',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(highContrast: appearance.highContrast),
              darkTheme: AppTheme.dark(highContrast: appearance.highContrast),
              themeMode: appearance.themeMode,
              locale: appearance.locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              routerConfig: _router,
              builder: (context, child) {
                return AppLifecycleGuard(
                  child: SessionActivityDetector(
                    child: child ?? const SizedBox.shrink(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
