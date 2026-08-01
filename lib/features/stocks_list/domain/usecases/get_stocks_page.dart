import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/ticker_page.dart';
import '../repositories/stocks_list_repository.dart';

class GetStocksPage {
  const GetStocksPage(this._repository);

  final StocksListRepository _repository;

  Future<Either<Failure, TickerPage>> call({
    required String query,
    String? cursor,
  }) => _repository.getPage(query: query, cursor: cursor);
}
