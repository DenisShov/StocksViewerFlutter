import 'package:equatable/equatable.dart';

import 'stock_summary.dart';

class TickerPage extends Equatable {
  const TickerPage({required this.items, required this.nextCursor});

  final List<StockSummary> items;
  final String? nextCursor;

  @override
  List<Object?> get props => [items, nextCursor];
}
