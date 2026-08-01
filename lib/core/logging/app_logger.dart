import 'dart:developer' as developer;

class AppLogger {
  const AppLogger();

  static const String _name = 'StocksViewer';

  static const String redactedValue = '***REDACTED***';

  void logFailedRequest(String path, Object failure) {
    developer.log(
      'Request failed: ${redactApiKey(path)} -> ${failure.runtimeType}',
      name: _name,
      level: 900,
    );
  }

  void logMissingApiKey() {
    developer.log('API key is not configured', name: _name, level: 900);
  }

  void logInfo(String message) {
    developer.log(redactApiKey(message), name: _name, level: 800);
  }

  void logWarning(String message) {
    developer.log(redactApiKey(message), name: _name, level: 900);
  }

  void logError(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      redactApiKey(message),
      name: _name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static String redactApiKey(String value) {
    final queryStart = value.indexOf('?');
    if (queryStart < 0) {
      return _redactQueryString(value);
    }
    final base = value.substring(0, queryStart + 1);
    final query = value.substring(queryStart + 1);
    return '$base${_redactQueryString(query)}';
  }

  static Map<String, dynamic> redactApiKeyMap(Map<String, dynamic> map) {
    if (!map.containsKey('apiKey')) {
      return Map<String, dynamic>.from(map);
    }
    return {...map, 'apiKey': redactedValue};
  }

  static String _redactQueryString(String query) {
    if (query.isEmpty) return query;
    final segments = query.split('&');
    var changed = false;
    final redactedSegments = segments.map((segment) {
      final eqIndex = segment.indexOf('=');
      if (eqIndex < 0) return segment;
      final key = segment.substring(0, eqIndex);
      if (key == 'apiKey') {
        changed = true;
        return 'apiKey=$redactedValue';
      }
      return segment;
    }).toList();
    return changed ? redactedSegments.join('&') : query;
  }
}
