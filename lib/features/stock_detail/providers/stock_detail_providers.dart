import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart'
    show failureMapperProvider, stocksApiClientProvider;
import '../../../core/utils/clock.dart';
import '../data/datasources/stock_detail_remote_data_source.dart';
import '../data/mappers/stock_detail_mapper.dart';
import '../data/repositories/stock_detail_repository_impl.dart';
import '../domain/repositories/stock_detail_repository.dart';
import '../domain/usecases/get_stock_chart_data.dart';
import '../domain/usecases/get_stock_overview.dart';

/// The only file in the `stock_detail` feature that knows Riverpod exists
/// on the data side (Requirement 2 AC 3, AC 16). It constructs the data
/// source, the repository implementation, and the use cases; no other
/// file in this feature declares a provider (Requirement 2 AC 5).
///
/// Every provider here is a plain, hand-written `Provider` constructor
/// (Requirement 2 AC 17). `stocksApiClientProvider` and
/// `failureMapperProvider` are declared once in
/// `lib/core/providers/core_providers.dart` and read from here rather than
/// redeclared, since they are cross-feature infrastructure shared with
/// `stocks_list` (Requirement 2 AC 11).
final stockDetailRemoteDataSourceProvider = Provider<StockDetailRemoteDataSource>(
  (ref) => StockDetailRemoteDataSource(ref.watch(stocksApiClientProvider)),
);

final stockDetailMapperProvider = Provider<StockDetailMapper>(
  (ref) => const StockDetailMapper(),
);

final stockDetailRepositoryProvider = Provider<StockDetailRepository>(
  (ref) => StockDetailRepositoryImpl(
    ref.watch(stockDetailRemoteDataSourceProvider),
    ref.watch(stockDetailMapperProvider),
    ref.watch(failureMapperProvider),
  ),
);

final getStockOverviewProvider = Provider<GetStockOverview>(
  (ref) => GetStockOverview(ref.watch(stockDetailRepositoryProvider)),
);

/// [GetStockChartData] takes its clock as a `DateTime Function()`
/// constructor parameter rather than the `Clock` typedef (see that
/// class's doc comment on the domain allowlist), so [systemClock] is
/// passed directly; it already has that exact signature.
final getStockChartDataProvider = Provider<GetStockChartData>(
  (ref) => GetStockChartData(ref.watch(stockDetailRepositoryProvider), systemClock),
);
