import 'package:json_annotation/json_annotation.dart';

import 'ticker_dto.dart';

part 'tickers_response_dto.g.dart';

@JsonSerializable(
  checked: true,
  includeIfNull: true,
  fieldRename: FieldRename.snake,
)
class TickersResponseDto {
  const TickersResponseDto({
    this.nextUrl,
    this.requestId,
    this.count,
    this.results,
  });

  final String? nextUrl;
  final String? requestId;
  final int? count;
  final List<TickerDto>? results;

  factory TickersResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TickersResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TickersResponseDtoToJson(this);
}
