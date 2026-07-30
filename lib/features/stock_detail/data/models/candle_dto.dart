import 'package:json_annotation/json_annotation.dart';

part 'candle_dto.g.dart';

/// Data-transfer object for a single Candle record inside a
/// [StockChartResponseDto]'s `results` array (Requirement 16 AC 6).
///
/// `o`, `c`, `h`, `l`, and `t` are required; `v`, `vw`, and `n` are
/// nullable. [timestampMs] is milliseconds since the Unix epoch in UTC.
///
/// The payload keys are single letters that do not follow the
/// camelCase-to-snake_case pattern `fieldRename: FieldRename.snake`
/// would otherwise produce, so every field carries an explicit
/// `@JsonKey(name: ...)` override naming its payload key.
///
/// `includeIfNull: true` makes `toJson` emit all eight keys, with
/// `null` for every key that was absent or null in the source payload,
/// which is what the round-trip property of Requirement 16 AC 10 needs.
@JsonSerializable(checked: true, includeIfNull: true, fieldRename: FieldRename.snake)
class CandleDto {
  const CandleDto({
    required this.open,
    required this.close,
    required this.high,
    required this.low,
    required this.timestampMs,
    this.volume,
    this.volumeWeightedAveragePrice,
    this.transactionCount,
  });

  @JsonKey(name: 'v')
  final double? volume;

  @JsonKey(name: 'vw')
  final double? volumeWeightedAveragePrice;

  @JsonKey(name: 'o')
  final double open;

  @JsonKey(name: 'c')
  final double close;

  @JsonKey(name: 'h')
  final double high;

  @JsonKey(name: 'l')
  final double low;

  @JsonKey(name: 't')
  final int timestampMs;

  @JsonKey(name: 'n')
  final int? transactionCount;

  factory CandleDto.fromJson(Map<String, dynamic> json) => _$CandleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CandleDtoToJson(this);
}
