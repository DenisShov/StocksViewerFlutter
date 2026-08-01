import 'package:json_annotation/json_annotation.dart';

part 'ticker_dto.g.dart';

@JsonSerializable(
  checked: true,
  includeIfNull: true,
  fieldRename: FieldRename.snake,
)
class TickerDto {
  const TickerDto({
    required this.ticker,
    this.name,
    this.market,
    this.locale,
    this.primaryExchange,
    this.type,
    this.active,
    this.currencyName,
    this.cik,
    this.compositeFigi,
    this.shareClassFigi,
    this.lastUpdatedUtc,
  });

  final String ticker;
  final String? name;
  final String? market;
  final String? locale;
  final String? primaryExchange;
  final String? type;
  final bool? active;
  final String? currencyName;
  final String? cik;
  final String? compositeFigi;
  final String? shareClassFigi;
  final String? lastUpdatedUtc;

  factory TickerDto.fromJson(Map<String, dynamic> json) =>
      _$TickerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TickerDtoToJson(this);
}
