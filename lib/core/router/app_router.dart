import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'navigation_shell.dart';

GoRouter createAppRouter({
  required Widget stocksScreen,
  required Widget favoritesScreen,
  required Widget Function(String ticker) detailScreenBuilder,
}) {
  final stocksNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'stocksNavigator',
  );
  final favoritesNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'favoritesNavigator',
  );

  return GoRouter(
    initialLocation: '/stocks',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationShell(
            navigationShell: navigationShell,
            showNavigationBar: !state.uri.path.contains('/detail/'),
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: stocksNavigatorKey,
            routes: [
              GoRoute(
                path: '/stocks',
                builder: (_, _) => stocksScreen,
                routes: [
                  GoRoute(
                    path: 'detail/:ticker',
                    builder: (_, state) => detailScreenBuilder(
                      Uri.decodeComponent(state.pathParameters['ticker'] ?? ''),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: favoritesNavigatorKey,
            routes: [
              GoRoute(
                path: '/favorites',
                builder: (_, _) => favoritesScreen,
                routes: [
                  GoRoute(
                    path: 'detail/:ticker',
                    builder: (_, state) => detailScreenBuilder(
                      Uri.decodeComponent(state.pathParameters['ticker'] ?? ''),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
