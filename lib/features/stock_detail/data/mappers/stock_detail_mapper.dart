import '../../domain/entities/candle.dart';
import '../../domain/entities/company_address.dart';
import '../../domain/entities/company_branding.dart';
import '../../domain/entities/stock_overview.dart';
import '../models/address_dto.dart';
import '../models/branding_dto.dart';
import '../models/candle_dto.dart';
import '../models/stock_chart_response_dto.dart';
import '../models/stock_overview_response_dto.dart';

class StockDetailMapper {
  const StockDetailMapper();

  StockOverview toStockOverview(StockOverviewResponseDto dto) {
    final result = dto.results;
    return StockOverview(
      ticker: result.ticker,
      name: result.name,
      market: result.market,
      locale: result.locale,
      type: result.type,
      active: result.active,
      currencyName: result.currencyName,
      description: result.description,
      marketCap: result.marketCap,
      totalEmployees: result.totalEmployees,
      listDate: result.listDate,
      homepageUrl: result.homepageUrl,
      phoneNumber: result.phoneNumber,
      sicCode: result.sicCode,
      sicDescription: result.sicDescription,
      tickerRoot: result.tickerRoot,
      shareClassSharesOutstanding: result.shareClassSharesOutstanding,
      weightedSharesOutstanding: result.weightedSharesOutstanding,
      roundLot: result.roundLot,
      primaryExchange: result.primaryExchange,
      cik: result.cik,
      address: _toCompanyAddress(result.address),
      branding: _toCompanyBranding(result.branding),
    );
  }

  List<Candle> toCandles(StockChartResponseDto dto) {
    final results = dto.results ?? const [];
    return results.map(_toCandle).toList();
  }

  CompanyAddress? _toCompanyAddress(AddressDto? dto) {
    if (dto == null) return null;
    return CompanyAddress(
      address1: dto.address1,
      city: dto.city,
      state: dto.state,
      postalCode: dto.postalCode,
    );
  }

  CompanyBranding? _toCompanyBranding(BrandingDto? dto) {
    if (dto == null) return null;
    return CompanyBranding(logoUrl: dto.logoUrl, iconUrl: dto.iconUrl);
  }

  Candle _toCandle(CandleDto dto) => Candle(
    open: dto.open,
    high: dto.high,
    low: dto.low,
    close: dto.close,
    timestampMs: dto.timestampMs,
    volume: dto.volume,
    volumeWeightedAveragePrice: dto.volumeWeightedAveragePrice,
    transactionCount: dto.transactionCount,
  );
}
