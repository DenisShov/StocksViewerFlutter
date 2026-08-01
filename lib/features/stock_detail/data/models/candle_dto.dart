import 'package:json_annotation/json_annotation.dart';

part 'candle_dto.g.dart';

@JsonSerializable(
  checked: true,
  includeIfNull: true,
  fieldRename: FieldRename.snake,
)
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

  factory CandleDto.fromJson(Map<String, dynamic> json) =>
      _$CandleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CandleDtoToJson(this);
}
