import 'package:dio/dio.dart';

class ApiKeyInterceptor extends Interceptor {
  ApiKeyInterceptor(this._apiKey);

  final String _apiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters = {...options.queryParameters, 'apiKey': _apiKey};
    handler.next(options);
  }
}
