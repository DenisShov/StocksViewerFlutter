library;

class DateWindow {
  const DateWindow._();

  static ({String startDate, String endDate}) forPeriod(DateTime now) {
    return (startDate: format(twoYearsEarlier(now)), endDate: format(now));
  }

  static DateTime twoYearsEarlier(DateTime date) {
    final targetYear = date.year - 2;
    final targetMonth = date.month;
    final lastValidDay = _lastDayOfMonth(targetYear, targetMonth);
    final clampedDay = date.day < lastValidDay ? date.day : lastValidDay;
    return DateTime(targetYear, targetMonth, clampedDay);
  }

  static String format(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static int _lastDayOfMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
