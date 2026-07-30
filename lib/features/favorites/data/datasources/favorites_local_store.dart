import 'package:drift/drift.dart';

import '../../../../core/storage/app_database.dart';

/// Data-layer component persisting favorite stocks on the device
/// (Requirement 18).
///
/// Wraps the shared [AppDatabase] rather than being a generated Drift
/// accessor itself, so it can be constructed with a plain `AppDatabase`
/// instance and unit-tested without a second `build_runner` step.
class FavoritesLocalStore {
  const FavoritesLocalStore(this._db);

  final AppDatabase _db;

  /// Emits every stored favorite ordered by `name` ascending,
  /// case-insensitively, with ties broken by ascending `ticker`
  /// (Requirement 18 AC 4).
  ///
  /// Expressed as two `OrderingTerm`s, the first over `name.lower()`,
  /// which compiles to `ORDER BY LOWER(name) ASC, ticker ASC`. SQLite's
  /// `lower()` folds ASCII only, so names differing in case outside ASCII
  /// order by their stored bytes.
  Stream<List<FavoriteStockRow>> watchAll() =>
      (_db.select(_db.favoriteStocks)..orderBy([
            (t) =>
                OrderingTerm(expression: t.name.lower(), mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.ticker, mode: OrderingMode.asc),
          ]))
          .watch();

  /// Emits whether a record with the exact [ticker] is stored, and only
  /// re-emits when that boolean value changes so unrelated writes do not
  /// rebuild the detail screen (Requirement 18 AC 5).
  Stream<bool> watchIsFavorite(String ticker) =>
      (_db.selectOnly(_db.favoriteStocks)
            ..addColumns([_db.favoriteStocks.ticker.count()])
            ..where(_db.favoriteStocks.ticker.equals(ticker)))
          .watchSingle()
          .map((row) => (row.read(_db.favoriteStocks.ticker.count()) ?? 0) > 0)
          .distinct();

  /// Inserts [row], or replaces `name`, `type`, and `primaryExchange` on
  /// the existing record sharing its `ticker`, leaving the row count
  /// unchanged (Requirement 18 AC 6).
  Future<void> upsert(FavoriteStockRow row) =>
      _db.into(_db.favoriteStocks).insertOnConflictUpdate(row);

  /// Removes the record holding [ticker]. Affects zero rows and completes
  /// without error when no record with that `ticker` is stored
  /// (Requirement 18 AC 10).
  Future<void> deleteByTicker(String ticker) =>
      (_db.delete(_db.favoriteStocks)..where((t) => t.ticker.equals(ticker)))
          .go();
}
