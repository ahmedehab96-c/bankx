import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../localization/app_localizations.dart';

/// Main shell with bottom navigation bar — single [Scaffold] for all tabs.
class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart_rounded),
            label: l10n.analytics,
          ),
          NavigationDestination(
            icon: const Icon(Icons.credit_card_outlined),
            selectedIcon: const Icon(Icons.credit_card_rounded),
            label: l10n.cards,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person_rounded),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }
}
