import 'package:equatable/equatable.dart';

/// A favorite stock persisted by the `Favorites_Local_Store`.
///
/// All four fields are non-null. When the source `StockOverview` lacks a
/// value for `name`, `type`, or `primaryExchange`, the empty string is
/// stored in its place. `type` carries the already-formatted type label
/// (for example `Common Stock`), never the raw Polygon type code.
class FavoriteStock extends Equatable {
  const FavoriteStock({
    required this.ticker,
    required this.name,
    required this.type,
    required this.primaryExchange,
  });

  final String ticker;
  final String name;
  final String type;
  final String primaryExchange;

  @override
  List<Object?> get props => [ticker, name, type, primaryExchange];
}
