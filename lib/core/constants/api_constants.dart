abstract final class ApiConstants {
  static const String baseUrl = 'https://api.polygon.io/';

  static const String tickerListPath = 'v3/reference/tickers';

  static const String companyOverviewPathTemplate =
      'v3/reference/tickers/{ticker}';

  static const String candleDataPathTemplate =
      'v2/aggs/ticker/{ticker}/range/1/{period}/{startDate}/{endDate}';

  static const int pageSize = 50;

  static const int candleLimit = 50000;

  static const int candleMultiplier = 1;

  static const Duration connectTimeout = Duration(seconds: 30);

  static const Duration sendTimeout = Duration(seconds: 30);

  static const Duration receiveTimeout = Duration(seconds: 30);
}
