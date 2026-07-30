import 'package:drift/drift.dart';

/// Drift table declaration for locally persisted favorite stocks.
///
/// `ticker` is the sole primary key, so at most one row exists per distinct
/// `ticker` value. SQLite's default `BINARY` collation on TEXT columns makes
/// the `ticker` comparison case-sensitive, which is what Requirement 18 AC 3
/// requires; no `COLLATE NOCASE` annotation is applied.
///
/// This table stores favorite records only: no ticker-list page and no
/// Candle data has a table (Requirement 18 AC 8).
@DataClassName('FavoriteStockRow')
class FavoriteStocks extends Table {
  TextColumn get ticker => text().withLength(min: 1, max: 16)();
  TextColumn get name => text().withLength(min: 0, max: 256)();
  TextColumn get type => text().withLength(min: 0, max: 64)();
  TextColumn get primaryExchange => text().withLength(min: 0, max: 64)();

  @override
  Set<Column> get primaryKey => {ticker};

  @override
  String get tableName => 'favorite_stocks';
}
