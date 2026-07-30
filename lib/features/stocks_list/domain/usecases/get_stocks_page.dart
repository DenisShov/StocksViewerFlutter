import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/ticker_page.dart';
import '../repositories/stocks_list_repository.dart';

/// Fetches a page of the stock ticker list.
///
/// A single concrete use case with no base class (Requirement 2 AC 13):
/// the reference template's abstract `UseCase<Output, Params>` base class
/// has almost no implementers and is deliberately omitted here.
class GetStocksPage {
  const GetStocksPage(this._repository);

  final StocksListRepository _repository;

  Future<Either<Failure, TickerPage>> call({
    required String query,
    String? cursor,
  }) => _repository.getPage(query: query, cursor: cursor);
}
