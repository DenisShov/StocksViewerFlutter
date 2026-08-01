library;

import 'package:flutter/material.dart';

import 'candle_colors.dart';
import 'color_schemes.dart';
import 'app_text_theme.dart';

class AppTheme {
  const AppTheme();

  ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: appTextTheme,
    scaffoldBackgroundColor: lightScaffoldBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.surfaceContainer,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: lightColorScheme.surfaceContainer,
    ),
    extensions: const <ThemeExtension<dynamic>>[lightCandleColors],
  );

  ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: appTextTheme,
    scaffoldBackgroundColor: darkScaffoldBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: darkColorScheme.surfaceContainer,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: darkColorScheme.surfaceContainer,
    ),
    extensions: const <ThemeExtension<dynamic>>[darkCandleColors],
  );
}
