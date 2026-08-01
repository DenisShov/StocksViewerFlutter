import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart'
    show failureMapperProvider, stocksApiClientProvider;
import '../data/datasources/stocks_remote_data_source.dart';
import '../data/mappers/stock_mapper.dart';
import '../data/repositories/stocks_list_repository_impl.dart';
import '../domain/repositories/stocks_list_repository.dart';
import '../domain/usecases/get_stocks_page.dart';

final stocksRemoteDataSourceProvider = Provider<StocksRemoteDataSource>(
  (ref) => StocksRemoteDataSource(ref.watch(stocksApiClientProvider)),
);

final stockMapperProvider = Provider<StockMapper>((ref) => const StockMapper());

final stocksListRepositoryProvider = Provider<StocksListRepository>(
  (ref) => StocksListRepositoryImpl(
    ref.watch(stocksRemoteDataSourceProvider),
    ref.watch(stockMapperProvider),
    ref.watch(failureMapperProvider),
  ),
);

final getStocksPageProvider = Provider<GetStocksPage>(
  (ref) => GetStocksPage(ref.watch(stocksListRepositoryProvider)),
);
