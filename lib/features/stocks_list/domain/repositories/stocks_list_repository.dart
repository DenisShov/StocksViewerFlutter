import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/ticker_page.dart';

abstract interface class StocksListRepository {
  Future<Either<Failure, TickerPage>> getPage({
    required String query,
    String? cursor,
  });
}
