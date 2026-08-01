import 'package:equatable/equatable.dart';

class StockSummary extends Equatable {
  const StockSummary({
    required this.ticker,
    this.name,
    this.type,
    this.primaryExchange,
  });

  final String ticker;
  final String? name;
  final String? type;
  final String? primaryExchange;

  @override
  List<Object?> get props => [ticker, name, type, primaryExchange];
}
