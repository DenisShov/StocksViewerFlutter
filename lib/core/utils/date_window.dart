/// The fixed 2-year Candle request window used by the Period_Selector
/// (Requirement 12 AC 12, AC 13).
///
/// This file is pure Dart: it has no Flutter import.
library;

/// Computes the `startDate` / `endDate` pair for a Candle data request.
///
/// The end date is the current device local calendar date. The start date is
/// the same month and day 2 calendar years earlier, with the day clamped to
/// the last valid day of the target month when the naive subtraction would
/// otherwise be invalid.
///
/// Dart's [DateTime] constructor rolls an invalid day forward to the next
/// month (`DateTime(2022, 2, 29)` normalizes to 2022-03-01), while Kotlin's
/// `LocalDate.minusYears(2)` clamps back to the last valid day of that month
/// instead. [twoYearsEarlier] matches Kotlin's behaviour: a 29 February
/// "today" yields a 28 February start date, not 1 March.
class DateWindow {
  const DateWindow._();

  /// Returns the formatted `startDate` / `endDate` pair for a Candle data
  /// request, given the current moment [now].
  ///
  /// `endDate` is [now] formatted `yyyy-MM-dd`; `startDate` is
  /// [twoYearsEarlier] of [now] formatted the same way.
  static ({String startDate, String endDate}) forPeriod(DateTime now) {
    return (
      startDate: format(twoYearsEarlier(now)),
      endDate: format(now),
    );
  }

  /// Returns the date 2 calendar years before [date], with the day clamped
  /// to the last valid day of the target month.
  static DateTime twoYearsEarlier(DateTime date) {
    final targetYear = date.year - 2;
    final targetMonth = date.month;
    final lastValidDay = _lastDayOfMonth(targetYear, targetMonth);
    final clampedDay = date.day < lastValidDay ? date.day : lastValidDay;
    return DateTime(targetYear, targetMonth, clampedDay);
  }

  /// Formats [date] as `yyyy-MM-dd` using manual zero-padding, so no `intl`
  /// locale data needs to be initialized to call this in a unit test.
  static String format(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  /// Returns the last valid day of [year]-[month], accounting for leap years.
  static int _lastDayOfMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
