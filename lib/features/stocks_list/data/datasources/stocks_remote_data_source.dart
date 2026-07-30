import 'package:json_annotation/json_annotation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/stocks_api_client.dart';
import '../models/tickers_response_dto.dart';

/// The data-layer component fetching one page of the ticker list or of
/// search results from the network.
///
/// [_client] is supplied through the constructor only, so this class
/// resolves nothing from a provider container (Requirement 2 AC 16).
class StocksRemoteDataSource {
  const StocksRemoteDataSource(this._client);

  final StocksApiClient _client;

  /// Fetches one page for [query].
  ///
  /// An empty [query] routes to [StocksApiClient.getStockList]; a
  /// non-empty [query] routes to [StocksApiClient.searchStockByQuery]
  /// (Requirement 7 AC 9, AC 10).
  ///
  /// A [CheckedFromJsonException] raised while decoding the response into
  /// [TickersResponseDto] is converted into a [ParseException]
  /// (Requirement 16 AC 8, AC 12).
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
