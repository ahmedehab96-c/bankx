import 'package:bankx/core/constants/app_routes.dart';
import 'package:bankx/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

/// Pumps [child] inside a localized [MaterialApp] for widget tests.
Future<void> pumpLocalizedWidget(
  WidgetTester tester,
  Widget child, {
  Locale locale = const Locale('en'),
  ThemeMode themeMode = ThemeMode.light,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: child,
    ),
  );
  await tester.pump();
}

/// Pumps a screen with GoRouter for navigation extension tests.
Future<void> pumpRoutedWidget(
  WidgetTester tester, {
  required String initialLocation,
  required Widget child,
  Locale locale = const Locale('en'),
}) async {
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(path: AppRoutes.login, builder: (_, _) => child),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, _) => const Scaffold(body: Text('Home')),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, _) => const Scaffold(body: Text('Register')),
      ),
    ],
  );

  await tester.pumpWidget(
    MaterialApp.router(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    ),
  );
  await tester.pumpAndSettle();
}

/// Wraps a screen with a single [BlocProvider] for isolated widget tests.
Widget withBloc<B extends BlocBase<S>, S>({
  required B bloc,
  required Widget child,
}) =>
    BlocProvider<B>.value(value: bloc, child: child);
