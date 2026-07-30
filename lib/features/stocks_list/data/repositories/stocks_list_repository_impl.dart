import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_mapper.dart';
import '../../domain/entities/ticker_page.dart';
import '../../domain/repositories/stocks_list_repository.dart';
import '../datasources/stocks_remote_data_source.dart';
import '../mappers/stock_mapper.dart';

/// The data-layer implementation of [StocksListRepository].
///
/// Every dependency is supplied through the constructor (Requirement 2 AC
/// 16). Every page is requested from [_dataSource], which always reaches
/// the network, so no page is ever served from a local read
/// (Requirement 6 AC 15).
class StocksListRepositoryImpl implements StocksListRepository {
  const StocksListRepositoryImpl(
    this._dataSource,
    this._mapper,
    this._failureMapper,
  );

  final StocksRemoteDataSource _dataSource;
  final StockMapper _mapper;
  final FailureMapper _failureMapper;

  @override
  Future<Either<Failure, TickerPage>> getPage({
    required String query,
    String? cursor,
  }) async {
    try {
      final dto = await _dataSource.fetchPage(query: query, cursor: cursor);
      return Right(_mapper.toTickerPage(dto));
    } catch (e) {
      return Left(_failureMapper.fromException(e));
    }
  }
}
