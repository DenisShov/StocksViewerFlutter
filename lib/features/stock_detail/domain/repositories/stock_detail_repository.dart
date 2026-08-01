import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/candle.dart';
import '../entities/stock_overview.dart';

abstract interface class StockDetailRepository {
  Future<Either<Failure, StockOverview>> getOverview(String ticker);

  Future<Either<Failure, List<Candle>>> getCandles({
    required String ticker,
    required String timespan,
    required String startDate,
    required String endDate,
  });
}
