import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/ticker_page.dart';

/// Repository boundary for fetching pages of the stock ticker list, both
/// the full list and search results (Requirement 2 AC 14).
abstract interface class StocksListRepository {
  Future<Either<Failure, TickerPage>> getPage({
    required String query,
    String? cursor,
  });
}
