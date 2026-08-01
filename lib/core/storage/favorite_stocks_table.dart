import 'package:drift/drift.dart';

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
