// Light and dark Material 3 color schemes for the App_Theme.
//
// Every color literal below is copied character for character from
// Requirement 3 AC 1 (light) and AC 2 (dark). These are `const` literals
// only: no `ColorScheme.fromSeed`, no `DynamicColorBuilder`, and no
// wallpaper-derived palette is used anywhere in this file or elsewhere in
// the codebase (Requirement 3 AC 5).
//
// `surfaceVariant` is deprecated by the Flutter framework in favor of
// `surfaceContainerHighest`, but Requirement 3 AC 1 and AC 2 specify a
// `surfaceVariant` value that is distinct from `surfaceContainerHighest` in
// both schemes, so it must be set explicitly to reproduce the exact
// requirement value. The resulting `deprecated_member_use` warning is
// suppressed on that single named argument in each scheme.
library;

import 'package:flutter/material.dart';

/// The light Material 3 color scheme (Requirement 3 AC 1).
const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF4F5B92),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFDDE1FF),
  onPrimaryContainer: Color(0xFF374379),
  secondary: Color(0xFF5A5D72),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFDFE1F9),
  onSecondaryContainer: Color(0xFF424659),
  tertiary: Color(0xFF76546E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD7F3),
  onTertiaryContainer: Color(0xFF5C3D56),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF93000A),
  surface: Color(0xFFFBF8FF),
  onSurface: Color(0xFF1B1B21),
  // ignore: deprecated_member_use
  surfaceVariant: Color(0xFFE2E1EC),
  onSurfaceVariant: Color(0xFF45464F),
  outline: Color(0xFF767680),
  outlineVariant: Color(0xFFC6C5D0),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFF303036),
  onInverseSurface: Color(0xFFF2F0F7),
  inversePrimary: Color(0xFFB8C3FF),
  surfaceDim: Color(0xFFDBD9E0),
  surfaceBright: Color(0xFFFBF8FF),
  surfaceContainerLowest: Color(0xFFFFFFFF),
  surfaceContainerLow: Color(0xFFF5F2FA),
  surfaceContainer: Color(0xFFEFEDF4),
  surfaceContainerHigh: Color(0xFFE9E7EF),
  surfaceContainerHighest: Color(0xFFE3E1E9),
);

/// The dark Material 3 color scheme (Requirement 3 AC 2).
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFB8C3FF),
  onPrimary: Color(0xFF202C61),
  primaryContainer: Color(0xFF374379),
  onPrimaryContainer: Color(0xFFDDE1FF),
  secondary: Color(0xFFC3C5DD),
  onSecondary: Color(0xFF2C2F42),
  secondaryContainer: Color(0xFF424659),
  onSecondaryContainer: Color(0xFFDFE1F9),
  tertiary: Color(0xFFE4BAD9),
  onTertiary: Color(0xFF44273F),
  tertiaryContainer: Color(0xFF5C3D56),
  onTertiaryContainer: Color(0xFFFFD7F3),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF121318),
  onSurface: Color(0xFFE3E1E9),
  // ignore: deprecated_member_use
  surfaceVariant: Color(0xFF45464F),
  onSurfaceVariant: Color(0xFFC6C5D0),
  outline: Color(0xFF90909A),
  outlineVariant: Color(0xFF45464F),
  scrim: Color(0xFF000000),
  inverseSurface: Color(0xFFE3E1E9),
  onInverseSurface: Color(0xFF303036),
  inversePrimary: Color(0xFF4F5B92),
  surfaceDim: Color(0xFF121318),
  surfaceBright: Color(0xFF38393F),
  surfaceContainerLowest: Color(0xFF0D0E13),
  surfaceContainerLow: Color(0xFF1B1B21),
  surfaceContainer: Color(0xFF1F1F25),
  surfaceContainerHigh: Color(0xFF292A2F),
  surfaceContainerHighest: Color(0xFF34343A),
);

/// Scaffold background colors (Requirement 3 AC 3).
const Color lightScaffoldBackground = Color(0xFFFBF8FF);
const Color darkScaffoldBackground = Color(0xFF121318);
