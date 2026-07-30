/// Build-time configuration for the Polygon.io API key.
///
/// The key is resolved from two distinct compile-time define names so that
/// the precedence rule (Requirement 15 AC 8) is deterministic regardless of
/// how the Flutter tool merges `--dart-define` with
/// `--dart-define-from-file`:
///
/// - `POLYGON_API_KEY`: supplied directly via `--dart-define`.
/// - `POLYGON_API_KEY_FILE`: supplied via an untracked environment file
///   passed with `--dart-define-from-file` (see `dart_defines/local.json`).
abstract final class AppConfig {
  static const String _fromDartDefine = String.fromEnvironment(
    'POLYGON_API_KEY',
  );
  static const String _fromEnvFile = String.fromEnvironment(
    'POLYGON_API_KEY_FILE',
  );

  /// The resolved Polygon.io API key.
  ///
  /// The Dart define wins when both sources supply a value
  /// (Requirement 15 AC 8).
  static String get polygonApiKey =>
      _fromDartDefine.isNotEmpty ? _fromDartDefine : _fromEnvFile;

  /// Whether a non-blank API key value is configured.
  static bool get isApiKeyConfigured => polygonApiKey.trim().isNotEmpty;
}
