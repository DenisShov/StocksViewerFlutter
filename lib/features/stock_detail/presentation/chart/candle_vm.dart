// The Candle_Chart's presentation-layer view model.
//
// `CandleSeries<CandleVm, String>` needs a data source whose x value is
// already the formatted category label (Requirement 11 AC 9), so this
// type carries that label alongside the four price fields the series
// mappers read; it holds nothing the chart package does not need.
library;

import 'package:equatable/equatable.dart';

import '../../../../core/utils/value_formatter.dart';
import '../../domain/entities/candle.dart';

/// One data point of the Candle_Chart's `CandleSeries`.
class CandleVm extends Equatable {
  const CandleVm({
    required this.label,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  /// Formats [candle] into a chart data point, using its device-local
  /// timestamp for the category [label] (Requirement 11 AC 9, AC 2).
  factory CandleVm.fromCandle(Candle candle) => CandleVm(
    label: ValueFormatter.formatCandleAxisDate(
      DateTime.fromMillisecondsSinceEpoch(candle.timestampMs),
    ),
    open: candle.open,
    high: candle.high,
    low: candle.low,
    close: candle.close,
  );

  /// The `MMM dd yyyy` category label, also the horizontal axis label
  /// text for this point (Requirement 11 AC 9).
  final String label;

  final double open;
  final double high;
  final double low;
  final double close;

  @override
  List<Object?> get props => [label, open, high, low, close];
}
