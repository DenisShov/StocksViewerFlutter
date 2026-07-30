import 'package:json_annotation/json_annotation.dart';

import 'address_dto.dart';
import 'branding_dto.dart';

part 'stock_overview_result_dto.g.dart';

/// Data-transfer object for the `results` object of a company overview
/// response (Requirement 16 AC 3).
///
/// `ticker` is the sole required field; the other twenty flat fields
/// plus the nested [address] and [branding] objects are nullable.
/// `fieldRename: FieldRename.snake` produces every snake_case payload
/// key from its camelCase field name, so no field needs an explicit
/// `@JsonKey(name: ...)` override.
@JsonSerializable(checked: true, includeIfNull: true, fieldRename: FieldRename.snake)
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
