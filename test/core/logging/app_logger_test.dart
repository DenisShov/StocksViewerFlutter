import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_viewer_flutter/core/logging/app_logger.dart';

void main() {
  group('AppLogger.redactApiKey', () {
    test('redacts an apiKey query parameter in a path with a query string', () {
      final result = AppLogger.redactApiKey('/v3/reference/tickers?apiKey=secret123&limit=50');

      expect(result, '/v3/reference/tickers?apiKey=***REDACTED***&limit=50');
      expect(result.contains('secret123'), isFalse);
    });

    test('redacts an apiKey parameter appearing anywhere in the query string', () {
      final result = AppLogger.redactApiKey('/v3/x?limit=50&apiKey=secret123&sort=asc');

      expect(result, '/v3/x?limit=50&apiKey=***REDACTED***&sort=asc');
    });

    test('redacts a bare query string with no leading path', () {
      final result = AppLogger.redactApiKey('apiKey=secret123&limit=50');

      expect(result, 'apiKey=***REDACTED***&limit=50');
    });

    test('leaves a differently-named parameter unchanged', () {
      const input = '/v3/x?otherApiKey=secret123&limit=50';

      expect(AppLogger.redactApiKey(input), input);
    });

    test('leaves a value with no query component unchanged', () {
      const input = '/v3/reference/tickers/AAPL';

      expect(AppLogger.redactApiKey(input), input);
    });

    test('leaves a value with a query string but no apiKey parameter unchanged', () {
      const input = '/v3/x?limit=50&sort=asc';

      expect(AppLogger.redactApiKey(input), input);
    });

    test('leaves an empty string unchanged', () {
      expect(AppLogger.redactApiKey(''), '');
    });
  });

  group('AppLogger.redactApiKeyMap', () {
    test('replaces the apiKey entry of a query-parameter map', () {
      final input = {'apiKey': 'secret123', 'limit': 50};

      final result = AppLogger.redactApiKeyMap(input);

      expect(result['apiKey'], AppLogger.redactedValue);
      expect(result['limit'], 50);
      expect(input['apiKey'], 'secret123', reason: 'input map must not be mutated');
    });

    test('returns an equivalent map when no apiKey entry is present', () {
      final input = {'limit': 50, 'sort': 'asc'};

      final result = AppLogger.redactApiKeyMap(input);

      expect(result, {'limit': 50, 'sort': 'asc'});
    });
  });

  group('AppLogger logging methods', () {
    test('logFailedRequest, logMissingApiKey, logInfo, logWarning, and logError run without throwing', () {
      const logger = AppLogger();

      expect(
        () => logger.logFailedRequest('/v3/x?apiKey=secret', Exception('boom')),
        returnsNormally,
      );
      expect(logger.logMissingApiKey, returnsNormally);
      expect(() => logger.logInfo('info with apiKey=secret in it'), returnsNormally);
      expect(() => logger.logWarning('warning message'), returnsNormally);
      expect(
        () => logger.logError('error message', Exception('boom'), StackTrace.current),
        returnsNormally,
      );
    });
  });
}
