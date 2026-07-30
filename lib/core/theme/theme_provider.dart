// The single provider exposing the App_Theme (Requirement 3 AC 17).
//
// This is the only theme-related provider in the codebase.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_theme.dart';

/// Exposes the light and dark themes of the Flutter_App.
final appThemeProvider = Provider<AppTheme>((ref) => const AppTheme());
