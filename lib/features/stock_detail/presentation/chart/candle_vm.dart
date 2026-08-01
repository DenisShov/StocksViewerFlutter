library;

import 'package:equatable/equatable.dart';

import '../../../../core/utils/value_formatter.dart';
import '../../domain/entities/candle.dart';

class CandleVm extends Equatable {
  const CandleVm({
    required this.label,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory CandleVm.fromCandle(Candle candle) => CandleVm(
    label: ValueFormatter.formatCandleAxisDate(
      DateTime.fromMillisecondsSinceEpoch(candle.timestampMs),
    ),
    open: candle.open,
    high: candle.high,
    low: candle.low,
    close: candle.close,
  );

  final String label;

  final double open;
  final double high;
  final double low;
  final double close;

  @override
  List<Object?> get props => [label, open, high, low, close];
}
