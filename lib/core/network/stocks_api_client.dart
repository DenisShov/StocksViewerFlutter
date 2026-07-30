import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../constants/app_config.dart';
import '../error/exceptions.dart';
import '../logging/app_logger.dart';

/// Hand-written Dio-based client for the four Polygon.io endpoints used by
/// the Flutter_App (Requirement 15).
///
/// This is a plain Dart class: both dependencies are supplied through the
/// constructor rather than resolved from a provider container
/// (Requirement 2 AC 16). It returns the raw decoded JSON body of each
/// response as a `Map<String, dynamic>`; mapping that JSON into a concrete
/// DTO via `fromJson` is the responsibility of the data source that calls
/// this client.
///
/// Every method checks [AppConfig.isApiKeyConfigured] before issuing a
/// request. When the key is absent or blank, no request is sent, the
/// missing-key condition is logged, and [ApiKeyMissingException] is thrown
/// (Requirement 15 AC 15).
class StocksApiClient {
  StocksApiClient(this._dio, this._logger);

  final Dio _dio;
  final AppLogger _logger;

  /// Requests one page of the full ticker list.
  ///
  /// Hits `v3/reference/tickers` with `market=stocks`, `active=true`,
  /// `limit=50`, and `cursor=<cursor>` only when [cursor] is supplied
  /// (Requirement 15 AC 2, AC 4).
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

  /// Requests one page of search results for [search].
  ///
  /// Hits `v3/reference/tickers` with `market=stocks`, `active=true`,
  /// `limit=50`, `search=<search>`, and `cursor=<cursor>` only when
  /// [cursor] is supplied (Requirement 15 AC 3, AC 4).
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

  /// Requests the company overview for [ticker].
  ///
  /// Hits `v3/reference/tickers/{ticker}` with no query parameter other
  /// than `apiKey` (Requirement 15 AC 5).
  Future<Map<String, dynamic>> getStockOverview({required String ticker}) {
    return _get(
      ApiConstants.companyOverviewPathTemplate.replaceFirst(
        '{ticker}',
        ticker,
      ),
    );
  }

  /// Requests candle data for [ticker] between [startDate] and [endDate]
  /// at the given [period] timespan.
  ///
  /// Hits `v2/aggs/ticker/{ticker}/range/1/{period}/{startDate}/{endDate}`
  /// with `adjusted=true`, `sort=asc`, and `limit=50000`
  /// (Requirement 15 AC 6).
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
