import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'favorite_stocks_table.dart';

part 'app_database.g.dart';

/// The application's local Drift database.
///
/// Holds favorite stock records only (Requirement 18 AC 8). The connection
/// is opened by `driftDatabase` from `drift_flutter`, which resolves a
/// platform-appropriate application storage directory and runs the SQLite
/// connection in a background isolate (Requirement 18 AC 1).
@DriftDatabase(tables: [FavoriteStocks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'stocks_viewer');
}
