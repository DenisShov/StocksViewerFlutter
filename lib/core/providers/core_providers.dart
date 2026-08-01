import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_config.dart';
import '../error/failure_mapper.dart';
import '../logging/app_logger.dart';
import '../network/branding_url_resolver.dart';
import '../network/dio_factory.dart';
import '../network/stocks_api_client.dart';

final dioProvider = Provider<Dio>((ref) => createDio());

final appLoggerProvider = Provider<AppLogger>((ref) => const AppLogger());

final stocksApiClientProvider = Provider<StocksApiClient>(
  (ref) =>
      StocksApiClient(ref.watch(dioProvider), ref.watch(appLoggerProvider)),
);

final failureMapperProvider = Provider<FailureMapper>(
  (ref) => const FailureMapper(),
);

final brandingUrlResolverProvider = Provider<BrandingUrlResolver>(
  (ref) => BrandingUrlResolver(apiKey: AppConfig.polygonApiKey),
);
