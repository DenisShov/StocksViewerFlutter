/// Pure-Dart display formatting helpers that mirror the Android app's
/// `String.format`/`NumberFormat` output exactly (Requirement 19).
///
/// No Flutter import here so this stays unit-testable without a widget
/// binding.
library;

import 'package:intl/intl.dart';

/// Namespace for stateless display-formatting functions.
abstract final class ValueFormatter {
  /// Maps a ticker type code to its human-readable label.
  ///
  /// Matching is case-sensitive: `CS` -> `Common Stock`,
  /// `ETF` -> `Exchange Traded Fund`, `ADRC` -> `Depositary Receipt`.
  /// Any other value, including the empty string or a differently-cased
  /// code such as `cs`, is returned unchanged.
  ///
  /// Validates: Requirements 19.1, 19.2, 19.3, 19.4
  static String formatType(String code) {
    switch (code) {
      case 'CS':
        return 'Common Stock';
      case 'ETF':
        return 'Exchange Traded Fund';
      case 'ADRC':
        return 'Depositary Receipt';
      default:
        return code;
    }
  }

  /// Formats a market capitalization value using the same scaling and
  /// half-up rounding as the Android app's Kotlin `%.2f` formatting.
  ///
  /// Returns `null` when [marketCap] is `null`. Otherwise divides by the
  /// largest applicable divisor (1e12/1e9/1e6/1e3) and appends the
  /// matching suffix (`T`/`B`/`M`/`K`); values below 1000 (including zero
  /// and negatives) are left unscaled with no suffix. The numeric portion
  /// always has exactly two digits after the decimal separator, no
  /// currency symbol, no thousands separator, and no whitespace, with a
  /// leading `-` retained for negative results.
  ///
  /// Validates: Requirements 19.5, 19.6, 19.7, 19.8, 19.9, 19.10, 19.11, 19.18
  static String? formatMarketCap(double? marketCap) {
    if (marketCap == null) return null;

    if (marketCap >= 1000000000000) {
      return '${_fixed2HalfUp(marketCap / 1000000000000)}T';
    }
    if (marketCap >= 1000000000) {
      return '${_fixed2HalfUp(marketCap / 1000000000)}B';
    }
    if (marketCap >= 1000000) {
      return '${_fixed2HalfUp(marketCap / 1000000)}M';
    }
    if (marketCap >= 1000) {
      return '${_fixed2HalfUp(marketCap / 1000)}K';
    }
    return _fixed2HalfUp(marketCap);
  }

  /// Formats an ISO `yyyy-MM-dd` listed date as `d MMMM yyyy` in the
  /// `en_US` locale, e.g. `2020-03-09` -> `9 March 2020`.
  ///
  /// Returns `null` when [isoDate] is `null`. Parsing uses `parseStrict` so
  /// that malformed strings and out-of-range calendar dates (such as
  /// `2020-13-45`, which the non-strict parser would silently accept) both
  /// return `null` instead of a formatted string, and any parsing
  /// exception is caught locally rather than propagated to the caller.
  ///
  /// Validates: Requirements 19.12, 19.13, 19.14, 19.18
  static String? formatListedDate(String? isoDate) {
    if (isoDate == null) return null;

    DateTime parsed;
    try {
      parsed = DateFormat('yyyy-MM-dd', 'en_US').parseStrict(isoDate);
    } catch (_) {
      return null;
    }

    return DateFormat('d MMMM yyyy', 'en_US').format(parsed);
  }

  /// Formats an employee count with thousands grouping in the `en_US`
  /// locale, e.g. `12345` -> `12,345`.
  ///
  /// Returns `null` when [count] is `null`.
  ///
  /// Validates: Requirements 19.15, 19.18, 19.19
  static String? formatEmployees(int? count) {
    if (count == null) return null;
    return NumberFormat.decimalPattern('en_US').format(count);
  }

  /// Joins the non-null address parts, in order, with `, ` as the
  /// separator, omitting any null field and emitting no separator for it.
  ///
  /// Returns the empty string when every field is `null`. `CompanyAddress`
  /// is introduced by a later task (stock_detail domain layer); callers
  /// with that entity should pass its four fields here, for example
  /// `ValueFormatter.formatAddress(address1: address?.address1, city:
  /// address?.city, state: address?.state, postalCode:
  /// address?.postalCode)`, which naturally yields `''` for a null
  /// `address` object as well as for an object whose four fields are all
  /// null.
  ///
  /// Validates: Requirements 19.16, 19.17, 19.20
  static String formatAddress({
    String? address1,
    String? city,
    String? state,
    String? postalCode,
  }) {
    return [
      address1,
      city,
      state,
      postalCode,
    ].whereType<String>().join(', ');
  }

  /// Formats a Candle timestamp as `MMM dd yyyy` in the `en_US` locale for
  /// the chart's horizontal axis labels.
  ///
  /// Validates: Requirements 11.9, 19.18
  static String formatCandleAxisDate(DateTime timestamp) {
    return DateFormat('MMM dd yyyy', 'en_US').format(timestamp);
  }

  /// Rounds [value] half-up to two decimal digits and renders it as
  /// `-?\d+\.\d{2}`, matching Kotlin's `"%.2f"` (`RoundingMode.HALF_UP`)
  /// rather than Dart's `toStringAsFixed`, which resolves ties to the
  /// numerically larger candidate instead of rounding away from zero.
  static String _fixed2HalfUp(double value) {
    final negative = value.isNegative;
    final scaled = value.abs() * 100;
    final floor = scaled.floorToDouble();
    final units = (scaled - floor >= 0.5 ? floor + 1 : floor).toInt();
    final text =
        '${units ~/ 100}.${(units % 100).toString().padLeft(2, '0')}';
    return negative && units != 0 ? '-$text' : text;
  }
}
