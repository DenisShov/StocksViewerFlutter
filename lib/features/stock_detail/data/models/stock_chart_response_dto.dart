import 'package:json_annotation/json_annotation.dart';

import 'candle_dto.dart';

part 'stock_chart_response_dto.g.dart';

/// Data-transfer object for the
/// `v2/aggs/ticker/{ticker}/range/1/{period}/{startDate}/{endDate}`
/// response (Requirement 16 AC 6).
///
/// All fields are nullable. `fieldRename: FieldRename.snake` converts
/// `queryCount` to `query_count` and `resultsCount` to `results_count`
/// automatically; `request_id` matches its camelCase field `requestId`
/// the same way, so no field needs an explicit `@JsonKey(name: ...)`
/// override.
@JsonSerializable(checked: true, includeIfNull: true, fieldRename: FieldRename.snake)
class StockChartResponseDto {
  const StockChartResponseDto({
    this.ticker,
    this.status,
    this.queryCount,
    this.resultsCount,
    this.adjusted,
    this.requestId,
    this.count,
    this.results,
  });

  final String? ticker;
  final String? status;
  final int? queryCount;
  final int? resultsCount;
  final bool? adjusted;
  final String? requestId;
  final int? count;
  final List<CandleDto>? results;

  factory StockChartResponseDto.fromJson(Map<String, dynamic> json) =>
      _$StockChartResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StockChartResponseDtoToJson(this);
}
