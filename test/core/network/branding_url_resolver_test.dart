import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_viewer_flutter/core/network/branding_url_resolver.dart';

void main() {
  group('BrandingUrlResolver', () {
    test('adds the API key while preserving existing query parameters', () {
      const resolver = BrandingUrlResolver(apiKey: 'secret');

      final result = resolver.resolve('https://example.com/logo.png?size=2');

      expect(result, 'https://example.com/logo.png?size=2&apiKey=secret');
    });

    test('does not add an empty API key', () {
      const resolver = BrandingUrlResolver(apiKey: '');

      expect(
        resolver.resolve('https://example.com/logo.png'),
        'https://example.com/logo.png',
      );
    });

    test('rejects missing and relative URLs', () {
      const resolver = BrandingUrlResolver(apiKey: 'secret');

      expect(resolver.resolve(null), isNull);
      expect(resolver.resolve(''), isNull);
      expect(resolver.resolve('/logo.png'), isNull);
    });
  });
}
