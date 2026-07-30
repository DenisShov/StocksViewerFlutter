import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../constants/app_config.dart';
import 'api_key_interceptor.dart';

/// Builds the single `Dio` instance used by the `StocksApiClient`.
///
/// The instance carries the base URL and the 30-second connect, send, and
/// receive timeouts (Requirement 15 AC 1, AC 18), and has the
/// `Api_Key_Interceptor` installed so every request issued through it
/// receives the `apiKey` query parameter (Requirement 15 AC 7).
///
/// This is the only `Dio` instance in the app. Image loading does not use
/// it, so no code path can append `apiKey` to an image URL
/// (Requirement 15 AC 10).
Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
    ),
  );
  dio.interceptors.add(ApiKeyInterceptor(AppConfig.polygonApiKey));
  return dio;
}
