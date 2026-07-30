import 'package:equatable/equatable.dart';

import 'stock_summary.dart';

/// One page of ticker results.
///
/// A `null` [nextCursor] means the list is exhausted and no further page
/// requests should be issued for the current query (Requirement 6 AC 12).
class TickerPage extends Equatable {
  const TickerPage({required this.items, required this.nextCursor});

  final List<StockSummary> items;
  final String? nextCursor;

  @override
  List<Object?> get props => [items, nextCursor];
}
