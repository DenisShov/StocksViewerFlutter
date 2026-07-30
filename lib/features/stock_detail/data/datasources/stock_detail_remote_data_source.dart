import 'package:json_annotation/json_annotation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/stocks_api_client.dart';
import '../models/stock_chart_response_dto.dart';
import '../models/stock_overview_response_dto.dart';

/// The data-layer component fetching a company overview or candle data
/// from the network.
///
/// [_client] is supplied through the constructor only, so this class
/// resolves nothing from a provider container (Requirement 2 AC 16).
class StockDetailRemoteDataSource {
  const StockDetailRemoteDataSource(this._client);

  final StocksApiClient _client;

  /// Fetches the company overview for [ticker].
  ///
  /// A [CheckedFromJsonException] raised while decoding the response into
  /// [StockOverviewResponseDto] is converted into a [ParseException]
  /// (Requirement 16 AC 8, AC 12).
  Future<StockOverviewResponseDto> fetchOverview(String ticker) async {
    final json = await _client.getStockOverview(ticker: ticker);
    try {
      return StockOverviewResponseDto.fromJson(json);
    } on CheckedFromJsonException catch (e) {
      throw ParseException(e.toString());
    }
  }

  /// Fetches candle data for [ticker] between [startDate] and [endDate]
  /// at the given [timespan].
  ///
  /// A [CheckedFromJsonException] raised while decoding the response into
  /// [StockChartResponseDto] is converted into a [ParseException]
  /// (Requirement 16 AC 8, AC 12).
  Future<StockChartResponseDto> fetchCandles({
    required String ticker,
    required String timespan,
    required String startDate,
    required String endDate,
  }) async {
    final json = await _client.getStockChartData(
      ticker: ticker,
      period: timespan,
      startDate: startDate,
      endDate: endDate,
    );
    try {
      return StockChartResponseDto.fromJson(json);
    } on CheckedFromJsonException catch (e) {
      throw ParseException(e.toString());
    }
  }
}
