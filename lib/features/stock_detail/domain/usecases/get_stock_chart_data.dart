import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/candle.dart';
import '../entities/period.dart';
import '../repositories/stock_detail_repository.dart';

/// Fetches the Candle request window and data for a ticker and [Period].
///
/// `GetStockChartData` owns the request window so the notifier holds no
/// date arithmetic. The clock is a constructor parameter (`DateTime
/// Function()`, spelled out rather than imported as the `Clock` typedef —
/// see the note below) so tests can fix the window without touching the
/// system clock.
///
/// Note on not importing `lib/core/utils/date_window.dart` /
/// `lib/core/utils/clock.dart`: the domain allowlist (Requirement 2 AC 1)
/// permits exactly one `core/` import, `lib/core/error/failure.dart`, and
/// the design's Architecture_Lint note states that exception is hard-coded
/// and any other `core/` import from `domain/` is rejected. Rather than
/// stretching that single documented exception to cover more files, the
/// small amount of date arithmetic `DateWindow` already implements
/// (`twoYearsEarlier`'s last-valid-day clamp and the `yyyy-MM-dd`
/// formatting) is duplicated here, in the domain layer, so the allowlist
/// stays exactly as documented. `test/architecture/` and task 8.3's
/// property test both exercise this window, so drift between the two
/// implementations would surface immediately.
class GetStockChartData {
  const GetStockChartData(this._repository, this._now);

  final StockDetailRepository _repository;
  final DateTime Function() _now;

  Future<Either<Failure, List<Candle>>> call({
    required String ticker,
    required Period period,
  }) {
    final now = _now();
    return _repository.getCandles(
      ticker: ticker,
      timespan: _timespanFor(period),
      startDate: _format(_twoYearsEarlier(now)),
      endDate: _format(now),
    );
  }

  String _timespanFor(Period period) => switch (period) {
    Period.day => 'day',
    Period.week => 'week',
    Period.month => 'month',
    Period.quartal => 'quarter',
  };

  /// Returns the date 2 calendar years before [date], with the day clamped
  /// to the last valid day of the target month (Requirement 12 AC 12),
  /// matching Kotlin's `LocalDate.minusYears(2)` rather than Dart's forward
  /// roll for an invalid day such as 29 February.
  DateTime _twoYearsEarlier(DateTime date) {
    final targetYear = date.year - 2;
    final targetMonth = date.month;
    final lastValidDay = _lastDayOfMonth(targetYear, targetMonth);
    final clampedDay = date.day < lastValidDay ? date.day : lastValidDay;
    return DateTime(targetYear, targetMonth, clampedDay);
  }

  int _lastDayOfMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  /// Formats [date] as `yyyy-MM-dd` (Requirement 12 AC 13) using manual
  /// zero-padding rather than `intl`, which is outside the domain
  /// allowlist.
  String _format(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
