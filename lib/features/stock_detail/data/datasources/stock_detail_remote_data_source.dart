import 'package:json_annotation/json_annotation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/stocks_api_client.dart';
import '../models/stock_chart_response_dto.dart';
import '../models/stock_overview_response_dto.dart';

class StockDetailRemoteDataSource {
  const StockDetailRemoteDataSource(this._client);

  final StocksApiClient _client;

  Future<StockOverviewResponseDto> fetchOverview(String ticker) async {
    final json = await _client.getStockOverview(ticker: ticker);
    try {
      return StockOverviewResponseDto.fromJson(json);
    } on CheckedFromJsonException catch (e) {
      throw ParseException(e.toString());
    }
  }

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
