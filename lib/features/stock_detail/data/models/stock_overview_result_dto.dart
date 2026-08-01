import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'branding_dto.dart';

part 'stock_overview_result_dto.g.dart';

@JsonSerializable(
  checked: true,
  includeIfNull: true,
  fieldRename: FieldRename.snake,
)
class StockOverviewResultDto {
  const StockOverviewResultDto({
    required this.ticker,
    this.name,
    this.market,
    this.locale,
    this.type,
    this.active,
    this.currencyName,
    this.description,
    this.marketCap,
    this.totalEmployees,
    this.listDate,
    this.homepageUrl,
    this.phoneNumber,
    this.sicCode,
    this.sicDescription,
    this.tickerRoot,
    this.shareClassSharesOutstanding,
    this.weightedSharesOutstanding,
    this.roundLot,
    this.primaryExchange,
    this.cik,
    this.address,
    this.branding,
  });

  final String ticker;
  final String? name;
  final String? market;
  final String? locale;
  final String? type;
  final bool? active;
  final String? currencyName;
  final String? description;
  final double? marketCap;
  final int? totalEmployees;
  final String? listDate;
  final String? homepageUrl;
  final String? phoneNumber;
  final String? sicCode;
  final String? sicDescription;
  final String? tickerRoot;
  final double? shareClassSharesOutstanding;
  final double? weightedSharesOutstanding;
  final int? roundLot;
  final String? primaryExchange;
  final String? cik;
  final AddressDto? address;
  final BrandingDto? branding;

  factory StockOverviewResultDto.fromJson(Map<String, dynamic> json) =>
      _$StockOverviewResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StockOverviewResultDtoToJson(this);
}
