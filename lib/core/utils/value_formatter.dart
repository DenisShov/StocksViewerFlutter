library;

import 'package:intl/intl.dart';

abstract final class ValueFormatter {
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

  static String? formatEmployees(int? count) {
    if (count == null) return null;
    return NumberFormat.decimalPattern('en_US').format(count);
  }

  static String formatAddress({
    String? address1,
    String? city,
    String? state,
    String? postalCode,
  }) {
    return [address1, city, state, postalCode].whereType<String>().join(', ');
  }

  static String formatCandleAxisDate(DateTime timestamp) {
    return DateFormat('MMM dd yyyy', 'en_US').format(timestamp);
  }

  static String _fixed2HalfUp(double value) {
    final negative = value.isNegative;
    final scaled = value.abs() * 100;
    final floor = scaled.floorToDouble();
    final units = (scaled - floor >= 0.5 ? floor + 1 : floor).toInt();
    final text = '${units ~/ 100}.${(units % 100).toString().padLeft(2, '0')}';
    return negative && units != 0 ? '-$text' : text;
  }
}
