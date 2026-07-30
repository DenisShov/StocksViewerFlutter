// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FavoriteStocksTable extends FavoriteStocks
    with TableInfo<$FavoriteStocksTable, FavoriteStockRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteStocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tickerMeta = const VerificationMeta('ticker');
  @override
  late final GeneratedColumn<String> ticker = GeneratedColumn<String>(
    'ticker',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 256,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryExchangeMeta = const VerificationMeta(
    'primaryExchange',
  );
  @override
  late final GeneratedColumn<String> primaryExchange = GeneratedColumn<String>(
    'primary_exchange',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [ticker, name, type, primaryExchange];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_stocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteStockRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ticker')) {
      context.handle(
        _tickerMeta,
        ticker.isAcceptableOrUnknown(data['ticker']!, _tickerMeta),
      );
    } else if (isInserting) {
      context.missing(_tickerMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('primary_exchange')) {
      context.handle(
        _primaryExchangeMeta,
        primaryExchange.isAcceptableOrUnknown(
          data['primary_exchange']!,
          _primaryExchangeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryExchangeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ticker};
  @override
  FavoriteStockRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteStockRow(
      ticker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ticker'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      primaryExchange: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_exchange'],
      )!,
    );
  }

  @override
  $FavoriteStocksTable createAlias(String alias) {
    return $FavoriteStocksTable(attachedDatabase, alias);
  }
}

class FavoriteStockRow extends DataClass
    implements Insertable<FavoriteStockRow> {
  final String ticker;
  final String name;
  final String type;
  final String primaryExchange;
  const FavoriteStockRow({
    required this.ticker,
    required this.name,
    required this.type,
    required this.primaryExchange,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ticker'] = Variable<String>(ticker);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['primary_exchange'] = Variable<String>(primaryExchange);
    return map;
  }

  FavoriteStocksCompanion toCompanion(bool nullToAbsent) {
    return FavoriteStocksCompanion(
      ticker: Value(ticker),
      name: Value(name),
      type: Value(type),
      primaryExchange: Value(primaryExchange),
    );
  }

  factory FavoriteStockRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteStockRow(
      ticker: serializer.fromJson<String>(json['ticker']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      primaryExchange: serializer.fromJson<String>(json['primaryExchange']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ticker': serializer.toJson<String>(ticker),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'primaryExchange': serializer.toJson<String>(primaryExchange),
    };
  }

  FavoriteStockRow copyWith({
    String? ticker,
    String? name,
    String? type,
    String? primaryExchange,
  }) => FavoriteStockRow(
    ticker: ticker ?? this.ticker,
    name: name ?? this.name,
    type: type ?? this.type,
    primaryExchange: primaryExchange ?? this.primaryExchange,
  );
  FavoriteStockRow copyWithCompanion(FavoriteStocksCompanion data) {
    return FavoriteStockRow(
      ticker: data.ticker.present ? data.ticker.value : this.ticker,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      primaryExchange: data.primaryExchange.present
          ? data.primaryExchange.value
          : this.primaryExchange,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteStockRow(')
          ..write('ticker: $ticker, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('primaryExchange: $primaryExchange')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(ticker, name, type, primaryExchange);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteStockRow &&
          other.ticker == this.ticker &&
          other.name == this.name &&
          other.type == this.type &&
          other.primaryExchange == this.primaryExchange);
}

class FavoriteStocksCompanion extends UpdateCompanion<FavoriteStockRow> {
  final Value<String> ticker;
  final Value<String> name;
  final Value<String> type;
  final Value<String> primaryExchange;
  final Value<int> rowid;
  const FavoriteStocksCompanion({
    this.ticker = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.primaryExchange = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteStocksCompanion.insert({
    required String ticker,
    required String name,
    required String type,
    required String primaryExchange,
    this.rowid = const Value.absent(),
  }) : ticker = Value(ticker),
       name = Value(name),
       type = Value(type),
       primaryExchange = Value(primaryExchange);
  static Insertable<FavoriteStockRow> custom({
    Expression<String>? ticker,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? primaryExchange,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ticker != null) 'ticker': ticker,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (primaryExchange != null) 'primary_exchange': primaryExchange,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteStocksCompanion copyWith({
    Value<String>? ticker,
    Value<String>? name,
    Value<String>? type,
    Value<String>? primaryExchange,
    Value<int>? rowid,
  }) {
    return FavoriteStocksCompanion(
      ticker: ticker ?? this.ticker,
      name: name ?? this.name,
      type: type ?? this.type,
      primaryExchange: primaryExchange ?? this.primaryExchange,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ticker.present) {
      map['ticker'] = Variable<String>(ticker.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (primaryExchange.present) {
      map['primary_exchange'] = Variable<String>(primaryExchange.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteStocksCompanion(')
          ..write('ticker: $ticker, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('primaryExchange: $primaryExchange, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteStocksTable favoriteStocks = $FavoriteStocksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoriteStocks];
}

typedef $$FavoriteStocksTableCreateCompanionBuilder =
    FavoriteStocksCompanion Function({
      required String ticker,
      required String name,
      required String type,
      required String primaryExchange,
      Value<int> rowid,
    });
typedef $$FavoriteStocksTableUpdateCompanionBuilder =
    FavoriteStocksCompanion Function({
      Value<String> ticker,
      Value<String> name,
      Value<String> type,
      Value<String> primaryExchange,
      Value<int> rowid,
    });

class $$FavoriteStocksTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteStocksTable> {
  $$FavoriteStocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryExchange => $composableBuilder(
    column: $table.primaryExchange,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteStocksTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteStocksTable> {
  $$FavoriteStocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryExchange => $composableBuilder(
    column: $table.primaryExchange,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteStocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteStocksTable> {
  $$FavoriteStocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ticker =>
      $composableBuilder(column: $table.ticker, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get primaryExchange => $composableBuilder(
    column: $table.primaryExchange,
    builder: (column) => column,
  );
}

class $$FavoriteStocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteStocksTable,
          FavoriteStockRow,
          $$FavoriteStocksTableFilterComposer,
          $$FavoriteStocksTableOrderingComposer,
          $$FavoriteStocksTableAnnotationComposer,
          $$FavoriteStocksTableCreateCompanionBuilder,
          $$FavoriteStocksTableUpdateCompanionBuilder,
          (
            FavoriteStockRow,
            BaseReferences<
              _$AppDatabase,
              $FavoriteStocksTable,
              FavoriteStockRow
            >,
          ),
          FavoriteStockRow,
          PrefetchHooks Function()
        > {
  $$FavoriteStocksTableTableManager(
    _$AppDatabase db,
    $FavoriteStocksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteStocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteStocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteStocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> ticker = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> primaryExchange = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteStocksCompanion(
                ticker: ticker,
                name: name,
                type: type,
                primaryExchange: primaryExchange,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String ticker,
                required String name,
                required String type,
                required String primaryExchange,
                Value<int> rowid = const Value.absent(),
              }) => FavoriteStocksCompanion.insert(
                ticker: ticker,
                name: name,
                type: type,
                primaryExchange: primaryExchange,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteStocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteStocksTable,
      FavoriteStockRow,
      $$FavoriteStocksTableFilterComposer,
      $$FavoriteStocksTableOrderingComposer,
      $$FavoriteStocksTableAnnotationComposer,
      $$FavoriteStocksTableCreateCompanionBuilder,
      $$FavoriteStocksTableUpdateCompanionBuilder,
      (
        FavoriteStockRow,
        BaseReferences<_$AppDatabase, $FavoriteStocksTable, FavoriteStockRow>,
      ),
      FavoriteStockRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteStocksTableTableManager get favoriteStocks =>
      $$FavoriteStocksTableTableManager(_db, _db.favoriteStocks);
}
