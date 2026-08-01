import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../constants/app_config.dart';
import 'api_key_interceptor.dart';

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
