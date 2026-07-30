// The App_Theme text theme.
//
// Flutter's `TextStyle.height` is a multiplier of the font size rather than
// a logical-pixel line height, so every requirement line height is
// expressed here as `height / fontSize`. Every size, line height, letter
// spacing, and weight below is copied character for character from
// Requirement 3 AC 6 through AC 15 and AC 18.
//
// The three label styles are declared explicitly rather than left to
// Flutter's Material 3 defaults: labelLarge's default letter spacing is
// 0.1, but Requirement 3 AC 15 requires 0.5, so it must be overridden. The
// label line heights are not constrained by the requirements and are set
// to the Material 3 defaults (20/16/16) so they do not drift.
//
// `fontFamily` is left unset on every style so each resolves to the
// platform default font family (Requirement 3 AC 16).
library;

import 'package:flutter/material.dart';

/// The App_Theme text theme (Requirement 3 AC 6 through AC 15, AC 18).
const TextTheme appTextTheme = TextTheme(
  // Requirement 3 AC 6: size 32, height 40, spacing 0, weight w400.
  headlineLarge: TextStyle(
    fontSize: 32,
    height: 40 / 32,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  ),
  // Requirement 3 AC 7: size 28, height 36, spacing 0, weight w400.
  headlineMedium: TextStyle(
    fontSize: 28,
    height: 36 / 28,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  ),
  // Requirement 3 AC 8: size 24, height 32, spacing 0, weight w400.
  headlineSmall: TextStyle(
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: 0,
    fontWeight: FontWeight.w400,
  ),
  // Requirement 3 AC 9: size 22, height 28, spacing 0, weight w700.
  titleLarge: TextStyle(
    fontSize: 22,
    height: 28 / 22,
    letterSpacing: 0,
    fontWeight: FontWeight.w700,
  ),
  // Requirement 3 AC 10: size 18, height 24, spacing 0.1, weight w700.
  titleMedium: TextStyle(
    fontSize: 18,
    height: 24 / 18,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w700,
  ),
  // Requirement 3 AC 11: size 14, height 20, spacing 0.1, weight w500.
  titleSmall: TextStyle(
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
  ),
  // Requirement 3 AC 12: size 16, height 24, spacing 0.5, weight w400.
  bodyLarge: TextStyle(
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w400,
  ),
  // Requirement 3 AC 13: size 14, height 20, spacing 0.25, weight w400.
  bodyMedium: TextStyle(
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.25,
    fontWeight: FontWeight.w400,
  ),
  // Requirement 3 AC 14: size 12, height 16, spacing 0.4, weight w400.
  bodySmall: TextStyle(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.4,
    fontWeight: FontWeight.w400,
  ),
  // Requirement 3 AC 15: size 14, spacing 0.5, weight w500. Line height set
  // to the Material 3 default (20) since the requirement does not
  // constrain it.
  labelLarge: TextStyle(
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w500,
  ),
  // Requirement 3 AC 15: size 12, spacing 0.5, weight w500. Line height set
  // to the Material 3 default (16) since the requirement does not
  // constrain it.
  labelMedium: TextStyle(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w500,
  ),
  // Requirement 3 AC 15: size 11, spacing 0.5, weight w500. Line height set
  // to the Material 3 default (16) since the requirement does not
  // constrain it.
  labelSmall: TextStyle(
    fontSize: 11,
    height: 16 / 11,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w500,
  ),
);
