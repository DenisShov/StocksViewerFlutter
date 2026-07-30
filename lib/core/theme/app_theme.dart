// The App_Theme itself, assembling the light and dark `ThemeData` from the
// color schemes, text theme, and candle color extension declared elsewhere
// in this directory.
//
// Only `colorScheme`, `textTheme`, `scaffoldBackgroundColor`, and
// `extensions` are set on each `ThemeData`; every other Material 3 token,
// including the entire shape scale, is left at its default value
// (Requirement 3 AC 19).
library;

import 'package:flutter/material.dart';

import 'candle_colors.dart';
import 'color_schemes.dart';
import 'app_text_theme.dart';

/// Supplies the light and dark `ThemeData` of the Flutter_App.
class AppTheme {
  const AppTheme();

  /// The light theme (Requirement 3 AC 1, AC 3, AC 6 through AC 19).
  ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: appTextTheme,
    scaffoldBackgroundColor: lightScaffoldBackground,
    extensions: const <ThemeExtension<dynamic>>[lightCandleColors],
  );

  /// The dark theme (Requirement 3 AC 2, AC 3, AC 6 through AC 19).
  ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: appTextTheme,
    scaffoldBackgroundColor: darkScaffoldBackground,
    extensions: const <ThemeExtension<dynamic>>[darkCandleColors],
  );
}
