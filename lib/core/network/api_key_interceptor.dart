import 'package:dio/dio.dart';

/// Appends the configured Polygon.io API key to every outgoing request.
///
/// The key is added as the `apiKey` query parameter, and every other query
/// parameter of the request is left unchanged (Requirement 15 AC 7).
///
/// This interceptor is installed only on the `Dio` instance built by
/// `dio_factory.dart`. Branding image URLs never pass through that `Dio`
/// instance, so no code path can append `apiKey` to an image URL
/// (Requirement 15 AC 10).
class ApiKeyInterceptor extends Interceptor {
  ApiKeyInterceptor(this._apiKey);

  final String _apiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters = {...options.queryParameters, 'apiKey': _apiKey};
    handler.next(options);
  }
}
