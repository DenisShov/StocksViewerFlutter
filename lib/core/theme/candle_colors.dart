// The candlestick bullish/bearish color extension for the App_Theme.
//
// Defined as a `ThemeExtension` rather than sampled from the Android
// Original, which never overrode Vico's default candle colors
// (Requirement 11 AC 14). A Candle whose close equals its open renders
// using the bullish color; there is no distinct neutral color.
library;

import 'package:flutter/material.dart';

/// Theme extension supplying the bullish and bearish candle colors used by
/// the Candle_Chart.
@immutable
class CandleColors extends ThemeExtension<CandleColors> {
  const CandleColors({required this.bullish, required this.bearish});

  /// Color used for a candle whose close is greater than or equal to its
  /// open.
  final Color bullish;

  /// Color used for a candle whose close is less than its open.
  final Color bearish;

  @override
  CandleColors copyWith({Color? bullish, Color? bearish}) {
    return CandleColors(
      bullish: bullish ?? this.bullish,
      bearish: bearish ?? this.bearish,
    );
  }

  @override
  CandleColors lerp(ThemeExtension<CandleColors>? other, double t) {
    if (other is! CandleColors) {
      return this;
    }
    return CandleColors(
      bullish: Color.lerp(bullish, other.bullish, t) ?? bullish,
      bearish: Color.lerp(bearish, other.bearish, t) ?? bearish,
    );
  }
}

/// The light-scheme candle colors (Requirement 11 AC 14).
const CandleColors lightCandleColors = CandleColors(
  bullish: Color(0xFF1B873F),
  bearish: Color(0xFFC62828),
);

/// The dark-scheme candle colors (Requirement 11 AC 14).
const CandleColors darkCandleColors = CandleColors(
  bullish: Color(0xFF4CC77C),
  bearish: Color(0xFFFF7A70),
);
