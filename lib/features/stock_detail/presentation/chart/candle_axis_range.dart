import '../../domain/entities/candle.dart';

/// The vertical axis range of the Candle_Chart, computed in the
/// presentation layer rather than by the chart package.
///
/// Precondition: `candles` passed to [CandleAxisRange.from] must be
/// non-empty; callers render the empty-chart message instead of this
/// range when there are no candles (Requirement 10 AC 8).
class CandleAxisRange {
  const CandleAxisRange({required this.minimum, required this.maximum});

  final double minimum;
  final double maximum;

  /// Computes the vertical axis range for [candles].
  ///
  /// The minimum is 10 times the floor of the lowest low divided by 10;
  /// the maximum is 10 times the ceiling of the highest high divided by
  /// 10 (Requirement 11 AC 6, AC 7). When the two would be equal (every
  /// candle's low and high fall on the same multiple of 10), the maximum
  /// is increased by 10 so the axis always has a non-zero span
  /// (Requirement 11 AC 16).
  factory CandleAxisRange.from(List<Candle> candles) {
    final lowestLow = candles
        .map((c) => c.low)
        .reduce((a, b) => a < b ? a : b);
    final highestHigh = candles
        .map((c) => c.high)
        .reduce((a, b) => a > b ? a : b);

    final minimum = 10 * (lowestLow / 10).floorToDouble();
    var maximum = 10 * (highestHigh / 10).ceilToDouble();

    if (maximum == minimum) {
      maximum += 10;
    }

    return CandleAxisRange(minimum: minimum, maximum: maximum);
  }
}
