import 'package:drift/drift.dart';

import '../../../../core/storage/app_database.dart';

class FavoritesLocalStore {
  const FavoritesLocalStore(this._db);

  final AppDatabase _db;

  Stream<List<FavoriteStockRow>> watchAll() =>
      (_db.select(_db.favoriteStocks)..orderBy([
            (t) => OrderingTerm(
              expression: t.name.lower(),
              mode: OrderingMode.asc,
            ),
            (t) => OrderingTerm(expression: t.ticker, mode: OrderingMode.asc),
          ]))
          .watch();

  Stream<bool> watchIsFavorite(String ticker) =>
      (_db.selectOnly(_db.favoriteStocks)
            ..addColumns([_db.favoriteStocks.ticker.count()])
            ..where(_db.favoriteStocks.ticker.equals(ticker)))
          .watchSingle()
          .map((row) => (row.read(_db.favoriteStocks.ticker.count()) ?? 0) > 0)
          .distinct();

  Future<void> upsert(FavoriteStockRow row) =>
      _db.into(_db.favoriteStocks).insertOnConflictUpdate(row);

  Future<void> deleteByTicker(String ticker) => (_db.delete(
    _db.favoriteStocks,
  )..where((t) => t.ticker.equals(ticker))).go();
}
