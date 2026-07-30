import 'dart:developer' as developer;

/// The single logging component of the Flutter_App.
///
/// This wraps `dart:developer`'s [developer.log] function and is the only
/// logging utility declared anywhere in `lib/` (Requirement 2 AC 10). No
/// other file may call [developer.log], `print`, or any other logging
/// package directly.
class AppLogger {
  const AppLogger();

  static const String _name = 'StocksViewer';

  /// The text substituted for the value of a redacted `apiKey` parameter.
  static const String redactedValue = '***REDACTED***';

  /// Logs a failed network call, recording the request [path] and the
  /// mapped [failure] subtype.
  ///
  /// [failure] is typically a `Failure` value produced by the
  /// `Failure_Mapper`, but any object is accepted so this file has no
  /// dependency on `lib/core/error/failure.dart`. Any `apiKey` query
  /// parameter present in [path] is redacted before it is logged.
  void logFailedRequest(String path, Object failure) {
    developer.log(
      'Request failed: ${redactApiKey(path)} -> ${failure.runtimeType}',
      name: _name,
      level: 900, // WARNING
    );
  }

  /// Logs the "API key is not configured" condition checked by the
  /// `StocksApiClient` before issuing any request.
  void logMissingApiKey() {
    developer.log(
      'API key is not configured',
      name: _name,
      level: 900, // WARNING
    );
  }

  /// Logs a non-fatal informational or debug message.
  ///
  /// Any `apiKey` query parameter present in [message] is redacted before
  /// it is logged.
  void logInfo(String message) {
    developer.log(redactApiKey(message), name: _name, level: 800); // INFO
  }

  /// Logs a non-fatal warning message.
  ///
  /// Any `apiKey` query parameter present in [message] is redacted before
  /// it is logged.
  void logWarning(String message) {
    developer.log(redactApiKey(message), name: _name, level: 900); // WARNING
  }

  /// Logs an error, optionally carrying the originating [error] and
  /// [stackTrace].
  ///
  /// Any `apiKey` query parameter present in [message] is redacted before
  /// it is logged.
  void logError(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      redactApiKey(message),
      name: _name,
      level: 1000, // SEVERE
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Redacts the value of a query parameter literally named `apiKey`
  /// wherever it occurs in [value].
  ///
  /// [value] may be a bare query string (`apiKey=secret&foo=bar`), a path
  /// with a query string appended (`/v3/x?apiKey=secret`), or a full URI.
  /// Only a parameter whose name is exactly `apiKey` is redacted; a
  /// differently-named parameter such as `otherApiKey` is left unchanged.
  /// A [value] with no query component, or no `apiKey` parameter, is
  /// returned unchanged.
  static String redactApiKey(String value) {
    final queryStart = value.indexOf('?');
    if (queryStart < 0) {
      return _redactQueryString(value);
    }
    final base = value.substring(0, queryStart + 1);
    final query = value.substring(queryStart + 1);
    return '$base${_redactQueryString(query)}';
  }

  /// Redacts the `apiKey` entry, if present, of a query-parameter [map]
  /// such as the one built by the `Api_Key_Interceptor`.
  ///
  /// Returns a new map; [map] itself is left unmodified. A [map] with no
  /// `apiKey` entry is returned as an equivalent copy.
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
