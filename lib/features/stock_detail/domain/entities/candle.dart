import 'package:equatable/equatable.dart';

class Candle extends Equatable {
  const Candle({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.timestampMs,
    this.volume,
    this.volumeWeightedAveragePrice,
    this.transactionCount,
  });

  final double open;
  final double high;
  final double low;
  final double close;
  final int timestampMs;
  final double? volume;
  final double? volumeWeightedAveragePrice;
  final int? transactionCount;

  @override
  List<Object?> get props => [
    open,
    high,
    low,
    close,
    timestampMs,
    volume,
    volumeWeightedAveragePrice,
    transactionCount,
  ];
}
