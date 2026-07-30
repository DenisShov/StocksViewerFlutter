import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/stock_overview.dart';
import '../repositories/stock_detail_repository.dart';

/// Fetches the company overview for a single ticker.
///
/// No use-case base class exists because none would have more than this one
/// concrete implementation (Requirement 2 AC 13).
class GetStockOverview {
  const GetStockOverview(this._repository);

  final StockDetailRepository _repository;

  Future<Either<Failure, StockOverview>> call(String ticker) =>
      _repository.getOverview(ticker);
}
