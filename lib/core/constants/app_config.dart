abstract final class AppConfig {
  static const String _fromDartDefine = String.fromEnvironment(
    'POLYGON_API_KEY',
  );
  static const String _fromEnvFile = String.fromEnvironment(
    'POLYGON_API_KEY_FILE',
  );

  static String get polygonApiKey =>
      _fromDartDefine.isNotEmpty ? _fromDartDefine : _fromEnvFile;

  static bool get isApiKeyConfigured => polygonApiKey.trim().isNotEmpty;
}
