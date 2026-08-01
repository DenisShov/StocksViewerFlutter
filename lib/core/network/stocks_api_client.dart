import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../constants/app_config.dart';
import '../error/exceptions.dart';
import '../logging/app_logger.dart';

class StocksApiClient {
  StocksApiClient(this._dio, this._logger);

  final Dio _dio;
  final AppLogger _logger;

  Future<Map<String, dynamic>> getStockList({String? cursor}) {
    return _get(
      ApiConstants.tickerListPath,
      queryParameters: {
        'market': 'stocks',
        'active': true,
        'limit': ApiConstants.pageSize,
        'cursor': ?cursor,
      },
    );
  }

  Future<Map<String, dynamic>> searchStockByQuery({
    required String search,
    String? cursor,
  }) {
    return _get(
      ApiConstants.tickerListPath,
      queryParameters: {
        'market': 'stocks',
        'active': true,
        'limit': ApiConstants.pageSize,
        'search': search,
        'cursor': ?cursor,
      },
    );
  }

  Future<Map<String, dynamic>> getStockOverview({required String ticker}) {
    return _get(
      ApiConstants.companyOverviewPathTemplate.replaceFirst('{ticker}', ticker),
    );
  }

  Future<Map<String, dynamic>> getStockChartData({
    required String ticker,
    required String period,
    required String startDate,
    required String endDate,
  }) {
    final path = ApiConstants.candleDataPathTemplate
        .replaceFirst('{ticker}', ticker)
        .replaceFirst('{period}', period)
        .replaceFirst('{startDate}', startDate)
        .replaceFirst('{endDate}', endDate);
    return _get(
      path,
      queryParameters: {
        'adjusted': true,
        'sort': 'asc',
        'limit': ApiConstants.candleLimit,
      },
    );
  }

  Future<Map<String, dynamic>> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!AppConfig.isApiKeyConfigured) {
      _logger.logMissingApiKey();
      throw const ApiKeyMissingException('API key is not configured');
    }
    final response = await _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParameters,
    );
    return response.data as Map<String, dynamic>;
  }
}
