import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart'
    show failureMapperProvider, stocksApiClientProvider;
import '../data/datasources/stocks_remote_data_source.dart';
import '../data/mappers/stock_mapper.dart';
import '../data/repositories/stocks_list_repository_impl.dart';
import '../domain/repositories/stocks_list_repository.dart';
import '../domain/usecases/get_stocks_page.dart';

/// The only file in the `stocks_list` feature that knows Riverpod exists
/// on the data side (Requirement 2 AC 3, AC 16). It constructs the data
/// source, the repository implementation, and the use case; no other file
/// in this feature declares a provider (Requirement 2 AC 5).
///
/// Every provider here is a plain, hand-written `Provider` constructor
/// (Requirement 2 AC 17). `dioProvider`, `appLoggerProvider`, and
/// `stocksApiClientProvider` are declared once in
/// `lib/core/providers/core_providers.dart` and read from here rather than
/// redeclared, since `StocksApiClient` and its dependencies are
/// cross-feature infrastructure shared with `stock_detail` (Requirement 2
/// AC 11).
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
