import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_mapper.dart';
import '../../domain/entities/candle.dart';
import '../../domain/entities/stock_overview.dart';
import '../../domain/repositories/stock_detail_repository.dart';
import '../datasources/stock_detail_remote_data_source.dart';
import '../mappers/stock_detail_mapper.dart';

class StockDetailRepositoryImpl implements StockDetailRepository {
  const StockDetailRepositoryImpl(
    this._dataSource,
    this._mapper,
    this._failureMapper,
  );

  final StockDetailRemoteDataSource _dataSource;
  final StockDetailMapper _mapper;
  final FailureMapper _failureMapper;

  @override
  Future<Either<Failure, StockOverview>> getOverview(String ticker) async {
    try {
      final dto = await _dataSource.fetchOverview(ticker);
      return Right(_mapper.toStockOverview(dto));
    } catch (e) {
      return Left(_failureMapper.fromException(e));
    }
  }

  @override
  Future<Either<Failure, List<Candle>>> getCandles({
    required String ticker,
    required String timespan,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final dto = await _dataSource.fetchCandles(
        ticker: ticker,
        timespan: timespan,
        startDate: startDate,
        endDate: endDate,
      );
      return Right(_mapper.toCandles(dto));
    } catch (e) {
      return Left(_failureMapper.fromException(e));
    }
  }
}
