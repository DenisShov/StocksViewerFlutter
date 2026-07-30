import 'package:json_annotation/json_annotation.dart';

import 'ticker_dto.dart';

part 'tickers_response_dto.g.dart';

/// Data-transfer object for the `v3/reference/tickers` response
/// (Requirement 16 AC 1).
///
/// All four fields are nullable. `fieldRename: FieldRename.snake`
/// converts `nextUrl` to `next_url` and `requestId` to `request_id`
/// automatically, so no field needs an explicit
/// `@JsonKey(name: ...)` override.
@JsonSerializable(checked: true, includeIfNull: true, fieldRename: FieldRename.snake)
class TickersResponseDto {
  const TickersResponseDto({this.nextUrl, this.requestId, this.count, this.results});

  final String? nextUrl;
  final String? requestId;
  final int? count;
  final List<TickerDto>? results;

  factory TickersResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TickersResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TickersResponseDtoToJson(this);
}
