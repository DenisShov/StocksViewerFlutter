import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_viewer_flutter/features/stock_detail/domain/entities/candle.dart';
import 'package:stocks_viewer_flutter/features/stock_detail/presentation/chart/candle_axis_range.dart';

Candle _candle({required double low, required double high}) => Candle(
  open: low,
  high: high,
  low: low,
  close: high,
  timestampMs: 0,
);

void main() {
  group('CandleAxisRange.from', () {
    test('a normal range floors the minimum and ceils the maximum to multiples of 10', () {
      final candles = [
        _candle(low: 123.4, high: 150.0),
        _candle(low: 130.0, high: 187.6),
      ];

      final range = CandleAxisRange.from(candles);

      expect(range.minimum, 120.0);
      expect(range.maximum, 190.0);
    });

    test('flat data widens a degenerate range by adding 10 to the maximum', () {
      final candles = [
        _candle(low: 150.0, high: 150.0),
        _candle(low: 150.0, high: 150.0),
      ];

      final range = CandleAxisRange.from(candles);

      expect(range.minimum, 150.0);
      expect(range.maximum, 160.0);
    });

    test('negative values floor toward negative infinity and ceil toward positive infinity', () {
      final candles = [_candle(low: -45.0, high: -12.0)];

      final range = CandleAxisRange.from(candles);

      expect(range.minimum, -50.0);
      expect(range.maximum, -10.0);
    });
  });
}
