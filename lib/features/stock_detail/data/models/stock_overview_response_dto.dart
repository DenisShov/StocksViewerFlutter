import 'package:json_annotation/json_annotation.dart';

import 'stock_overview_result_dto.dart';

part 'stock_overview_response_dto.g.dart';

@JsonSerializable(
  checked: true,
  includeIfNull: true,
  fieldRename: FieldRename.snake,
)
class StockOverviewResponseDto {
  const StockOverviewResponseDto({
    required this.results,
    this.requestId,
    this.status,
  });

  final StockOverviewResultDto results;
  final String? requestId;
  final String? status;

  factory StockOverviewResponseDto.fromJson(Map<String, dynamic> json) =>
      _$StockOverviewResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$StockOverviewResponseDtoToJson(this);
}
