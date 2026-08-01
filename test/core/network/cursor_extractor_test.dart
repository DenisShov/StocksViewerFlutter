import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_viewer_flutter/core/network/cursor_extractor.dart';

void main() {
  group('extractCursor', () {
    test('returns every character after the first cursor= occurrence, '
        'with no truncation at a later &', () {
      const nextUrl =
          'https://api.polygon.io/v3/reference/tickers?cursor=abc123&limit=50';

      expect(extractCursor(nextUrl), 'abc123&limit=50');
    });

    test('returns null for a null next_url', () {
      expect(extractCursor(null), isNull);
    });

    test('returns null when next_url contains no cursor= occurrence', () {
      const nextUrl = 'https://api.polygon.io/v3/reference/tickers?limit=50';

      expect(extractCursor(nextUrl), isNull);
    });

    test('returns null rather than the empty string when zero characters '
        'follow cursor=', () {
      const nextUrl =
          'https://api.polygon.io/v3/reference/tickers?limit=50&cursor=';

      expect(extractCursor(nextUrl), isNull);
    });
  });
}
