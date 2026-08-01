import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/theme_provider.dart';
import 'features/favorites/presentation/screens/favorites_screen.dart';
import 'features/stock_detail/presentation/screens/stock_detail_screen.dart';
import 'features/stocks_list/presentation/screens/stocks_list_screen.dart';
import 'l10n/generated/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: StocksViewerApp()));
}

class StocksViewerApp extends ConsumerStatefulWidget {
  const StocksViewerApp({super.key});

  @override
  ConsumerState<StocksViewerApp> createState() => _StocksViewerAppState();
}

class _StocksViewerAppState extends ConsumerState<StocksViewerApp> {
  late final _router = createAppRouter(
    stocksScreen: const StocksListScreen(),
    favoritesScreen: const FavoritesScreen(),
    detailScreenBuilder: (ticker) => StockDetailScreen(ticker: ticker),
  );

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return MaterialApp.router(
      title: 'StocksViewer',
      routerConfig: _router,
      theme: theme.light,
      darkTheme: theme.dark,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
    );
  }
}
