import 'package:equatable/equatable.dart';

/// A single ticker entry in a stock list page.
///
/// Domain scoping decision: only the fields actually consumed by a
/// downstream requirement are represented here. The full per-ticker DTO
/// (Requirement 16 AC 2) carries twelve fields; only `ticker`, `name`,
/// `type`, and `primaryExchange` are used by the list-row rendering
/// (Requirement 6/7) and the favorite record fields (Requirement 13 AC 5).
/// `type` holds the raw, unformatted type code (e.g. `CS`, `ETF`);
/// formatting for display happens in the presentation layer via
/// `ValueFormatter.formatType`.
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
