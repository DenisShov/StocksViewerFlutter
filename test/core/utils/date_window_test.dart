import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_viewer_flutter/core/utils/date_window.dart';

void main() {
  group('DateWindow.twoYearsEarlier', () {
    test('returns the same month and day 2 calendar years earlier', () {
      final today = DateTime(2024, 6, 15);
      final start = DateWindow.twoYearsEarlier(today);

      expect(start, DateTime(2022, 6, 15));
    });

    test('clamps 29 February to 28 February when the target year is not a '
        'leap year, matching Kotlin\'s LocalDate.minusYears(2) instead of '
        "Dart's forward roll to 1 March", () {
      final today = DateTime(2024, 2, 29);
      final start = DateWindow.twoYearsEarlier(today);

      expect(start, DateTime(2022, 2, 28));
      expect(start, isNot(DateTime(2022, 3, 1)));
    });

    test('leaves a month-end date unrelated to leap-year length unchanged, '
        'as a contrast to the leap day clamp', () {
      final today = DateTime(2024, 10, 31);
      final start = DateWindow.twoYearsEarlier(today);

      expect(start, DateTime(2022, 10, 31));
    });
  });

  group('DateWindow.format', () {
    test('formats as yyyy-MM-dd with zero-padded month and day', () {
      final formatted = DateWindow.format(DateTime(2024, 1, 5));

      expect(formatted, '2024-01-05');
    });
  });

  group('DateWindow.forPeriod', () {
    test('returns both dates formatted yyyy-MM-dd', () {
      final window = DateWindow.forPeriod(DateTime(2024, 2, 29));

      expect(window.endDate, '2024-02-29');
      expect(window.startDate, '2022-02-28');
    });
  });
}
