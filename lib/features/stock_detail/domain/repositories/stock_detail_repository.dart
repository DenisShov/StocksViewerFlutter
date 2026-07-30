import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/candle.dart';
import '../entities/stock_overview.dart';

/// Repository boundary for fetching a company overview and its candle
/// data (Requirement 2 AC 14).
abstract interface class StockDetailRepository {
  Future<Either<Failure, StockOverview>> getOverview(String ticker);

  Future<Either<Failure, List<Candle>>> getCandles({
    required String ticker,
    required String timespan,
    required String startDate,
    required String endDate,
  });
}
