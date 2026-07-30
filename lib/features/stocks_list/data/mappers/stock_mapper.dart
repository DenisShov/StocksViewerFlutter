import '../../domain/entities/stock_summary.dart';
import '../../domain/entities/ticker_page.dart';
import '../../../../core/network/cursor_extractor.dart';
import '../models/ticker_dto.dart';
import '../models/tickers_response_dto.dart';

/// The data-layer component converting a [TickersResponseDto] into a
/// [TickerPage] (Requirement 16 AC 9).
///
/// This class carries no serialization annotation itself; it only reads
/// the DTO fields already decoded by `json_serializable` and produces
/// plain domain entities that reference no DTO type.
class StockMapper {
  const StockMapper();

  /// Maps [dto] to a [TickerPage].
  ///
  /// One [StockSummary] is produced per `results` entry, in payload order
  /// (Requirement 16 AC 7). An absent, null, or empty `results` list
  /// produces an empty `items` list with no parse failure (Requirement 16
  /// AC 11), since `dto.results ?? const []` never throws.
  ///
  /// `nextCursor` is derived from `extractCursor(dto.nextUrl)`
  /// (Requirement 15 AC 11-13, reused for Requirement 16 AC 1).
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
