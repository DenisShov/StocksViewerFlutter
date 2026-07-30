// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_overview_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockOverviewResponseDto _$StockOverviewResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('StockOverviewResponseDto', json, ($checkedConvert) {
  final val = StockOverviewResponseDto(
    results: $checkedConvert(
      'results',
      (v) => StockOverviewResultDto.fromJson(v as Map<String, dynamic>),
    ),
    requestId: $checkedConvert('request_id', (v) => v as String?),
    status: $checkedConvert('status', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'requestId': 'request_id'});

Map<String, dynamic> _$StockOverviewResponseDtoToJson(
  StockOverviewResponseDto instance,
) => <String, dynamic>{
  'results': instance.results,
  'request_id': instance.requestId,
  'status': instance.status,
};
