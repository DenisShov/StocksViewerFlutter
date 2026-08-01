import '../../domain/entities/stock_summary.dart';
import '../../domain/entities/ticker_page.dart';
import '../../../../core/network/cursor_extractor.dart';
import '../models/ticker_dto.dart';
import '../models/tickers_response_dto.dart';

class StockMapper {
  const StockMapper();

  TickerPage toTickerPage(TickersResponseDto dto) {
    final results = dto.results ?? const [];
    return TickerPage(
      items: results.map(_toStockSummary).toList(),
      nextCursor: extractCursor(dto.nextUrl),
    );
  }

  StockSummary _toStockSummary(TickerDto dto) => StockSummary(
    ticker: dto.ticker,
    name: dto.name,
    type: dto.type,
    primaryExchange: dto.primaryExchange,
  );
}
