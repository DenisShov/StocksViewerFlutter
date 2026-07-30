import 'package:json_annotation/json_annotation.dart';

part 'ticker_dto.g.dart';

/// Data-transfer object for a single ticker entry inside a
/// [TickersResponseDto]'s `results` array.
///
/// `ticker` is the sole required field; the other eleven fields are
/// nullable (Requirement 16 AC 2). Every field name is expressed in
/// camelCase and relies on `fieldRename: FieldRename.snake` to produce
/// the exact snake_case payload key, so no field needs an explicit
/// `@JsonKey(name: ...)` override.
@JsonSerializable(checked: true, includeIfNull: true, fieldRename: FieldRename.snake)
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

  factory TickerDto.fromJson(Map<String, dynamic> json) => _$TickerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TickerDtoToJson(this);
}
