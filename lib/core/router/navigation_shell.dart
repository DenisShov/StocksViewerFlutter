import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/app_localizations.dart';

class NavigationShell extends StatelessWidget {
  const NavigationShell({
    required this.navigationShell,
    required this.showNavigationBar,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final bool showNavigationBar;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: showNavigationBar
          ? NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              onDestinationSelected: (index) {
                navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                );
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: l10n.stocksNavigationLabel,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.star_border),
                  selectedIcon: const Icon(Icons.star),
                  label: l10n.favoritesTitle,
                ),
              ],
            )
          : null,
    );
  }
}
