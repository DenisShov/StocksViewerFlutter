/// Constants describing the Polygon.io REST API surface used by the
/// Stocks_Api_Client (Requirement 15).
abstract final class ApiConstants {
  /// The Polygon.io API base URL (Requirement 15 AC 1).
  static const String baseUrl = 'https://api.polygon.io/';

  /// Path template for the ticker list and search endpoints
  /// (Requirement 15 AC 2, AC 3).
  static const String tickerListPath = 'v3/reference/tickers';

  /// Path template for the company overview endpoint. `{ticker}` must be
  /// replaced with the requested ticker symbol (Requirement 15 AC 5).
  static const String companyOverviewPathTemplate =
      'v3/reference/tickers/{ticker}';

  /// Path template for the candle (aggregates) endpoint. `{ticker}`,
  /// `{period}`, `{startDate}`, and `{endDate}` must be replaced with the
  /// requested values (Requirement 15 AC 6).
  static const String candleDataPathTemplate =
      'v2/aggs/ticker/{ticker}/range/1/{period}/{startDate}/{endDate}';

  /// Page size applied to ticker list and search requests
  /// (Requirement 15 AC 2, AC 3).
  static const int pageSize = 50;

  /// Maximum number of candle records requested per call
  /// (Requirement 15 AC 6).
  static const int candleLimit = 50000;

  /// The aggregation window multiplier applied to candle requests, i.e. the
  /// `1` in `range/1/{period}/...` (Requirement 15 AC 6).
  static const int candleMultiplier = 1;

  /// Connection timeout applied to every request (Requirement 15 AC 18).
  static const Duration connectTimeout = Duration(seconds: 30);

  /// Send timeout applied to every request (Requirement 15 AC 18).
  static const Duration sendTimeout = Duration(seconds: 30);

  /// Receive timeout applied to every request (Requirement 15 AC 18).
  static const Duration receiveTimeout = Duration(seconds: 30);
}
