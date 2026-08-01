import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/stock_overview.dart';
import '../repositories/stock_detail_repository.dart';

class GetStockOverview {
  const GetStockOverview(this._repository);

  final StockDetailRepository _repository;

  Future<Either<Failure, StockOverview>> call(String ticker) =>
      _repository.getOverview(ticker);
}
