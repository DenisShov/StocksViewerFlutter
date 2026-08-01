library;

import 'package:flutter/material.dart';

@immutable
class CandleColors extends ThemeExtension<CandleColors> {
  const CandleColors({required this.bullish, required this.bearish});

  final Color bullish;

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

const CandleColors lightCandleColors = CandleColors(
  bullish: Color(0xFF1B873F),
  bearish: Color(0xFFC62828),
);

const CandleColors darkCandleColors = CandleColors(
  bullish: Color(0xFF4CC77C),
  bearish: Color(0xFFFF7A70),
);
