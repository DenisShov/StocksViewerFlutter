import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/candle.dart';
import '../entities/period.dart';
import '../repositories/stock_detail_repository.dart';
import '../services/date_window.dart';

class GetStockChartData {
  const GetStockChartData(this._repository, this._now);

  final StockDetailRepository _repository;
  final DateTime Function() _now;

  Future<Either<Failure, List<Candle>>> call({
    required String ticker,
    required Period period,
  }) {
    final now = _now();
    final window = DateWindow.forPeriod(now);
    return _repository.getCandles(
      ticker: ticker,
      timespan: _timespanFor(period),
      startDate: window.startDate,
      endDate: window.endDate,
    );
  }

  String _timespanFor(Period period) => switch (period) {
    Period.day => 'day',
    Period.week => 'week',
    Period.month => 'month',
    Period.quartal => 'quarter',
  };
}
