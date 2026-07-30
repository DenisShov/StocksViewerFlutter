/// Data-layer exception types thrown by the network and storage layers.
///
/// This file is pure Dart: it has no Flutter import. Exceptions declared
/// here are caught by repository implementations and translated into
/// [Failure] values by the `FailureMapper`; they never reach the
/// presentation layer.
library;

/// Thrown when a response body cannot be parsed into the expected shape.
class ParseException implements Exception {
  const ParseException([this.message]);

  final String? message;

  @override
  String toString() =>
      message == null ? 'ParseException' : 'ParseException: $message';
}

/// Thrown when a network request is attempted while the Polygon.io API key
/// is absent or blank.
class ApiKeyMissingException implements Exception {
  const ApiKeyMissingException([this.message]);

  final String? message;

  @override
  String toString() => message == null
      ? 'ApiKeyMissingException'
      : 'ApiKeyMissingException: $message';
}

/// Thrown when a local persistence operation (the favorites store) fails.
class LocalStoreException implements Exception {
  const LocalStoreException([this.message]);

  final String? message;

  @override
  String toString() => message == null
      ? 'LocalStoreException'
      : 'LocalStoreException: $message';
}
