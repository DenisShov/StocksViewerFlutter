library;

class ParseException implements Exception {
  const ParseException([this.message]);

  final String? message;

  @override
  String toString() =>
      message == null ? 'ParseException' : 'ParseException: $message';
}

class ApiKeyMissingException implements Exception {
  const ApiKeyMissingException([this.message]);

  final String? message;

  @override
  String toString() => message == null
      ? 'ApiKeyMissingException'
      : 'ApiKeyMissingException: $message';
}

class LocalStoreException implements Exception {
  const LocalStoreException([this.message]);

  final String? message;

  @override
  String toString() =>
      message == null ? 'LocalStoreException' : 'LocalStoreException: $message';
}
