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

final stockDetailRemoteDataSourceProvider =
    Provider<StockDetailRemoteDataSource>(
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

final getStockChartDataProvider = Provider<GetStockChartData>(
  (ref) =>
      GetStockChartData(ref.watch(stockDetailRepositoryProvider), systemClock),
);
