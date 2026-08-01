import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'favorite_stocks_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [FavoriteStocks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'stocks_viewer');
}
