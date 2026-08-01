import '../../domain/entities/candle.dart';

class CandleAxisRange {
  const CandleAxisRange({required this.minimum, required this.maximum});

  final double minimum;
  final double maximum;

  factory CandleAxisRange.from(List<Candle> candles) {
    final lowestLow = candles.map((c) => c.low).reduce((a, b) => a < b ? a : b);
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
