import 'package:json_annotation/json_annotation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/stocks_api_client.dart';
import '../models/tickers_response_dto.dart';

class StocksRemoteDataSource {
  const StocksRemoteDataSource(this._client);

  final StocksApiClient _client;

  Future<TickersResponseDto> fetchPage({
    required String query,
    String? cursor,
  }) async {
    final json = query.isEmpty
        ? await _client.getStockList(cursor: cursor)
        : await _client.searchStockByQuery(search: query, cursor: cursor);
    try {
      return TickersResponseDto.fromJson(json);
    } on CheckedFromJsonException catch (e) {
      throw ParseException(e.toString());
    }
  }
}
