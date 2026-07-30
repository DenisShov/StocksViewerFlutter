import 'package:json_annotation/json_annotation.dart';

import 'stock_overview_result_dto.dart';

part 'stock_overview_response_dto.g.dart';

/// Data-transfer object for the `v3/reference/tickers/{ticker}` response
/// (Requirement 16 AC 3).
///
/// `results` is the sole required field; the envelope's own metadata
/// fields are nullable. `fieldRename: FieldRename.snake` converts
/// `requestId` to `request_id` automatically, so no field needs an
/// explicit `@JsonKey(name: ...)` override.
@JsonSerializable(checked: true, includeIfNull: true, fieldRename: FieldRename.snake)
class StockOverviewResponseDto {
  const StockOverviewResponseDto({required this.results, this.requestId, this.status});

  final StockOverviewResultDto results;
  final String? requestId;
  final String? status;

  factory StockOverviewResponseDto.fromJson(Map<String, dynamic> json) =>
      _$StockOverviewResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StockOverviewResponseDtoToJson(this);
}
