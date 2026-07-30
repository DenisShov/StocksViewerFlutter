// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_chart_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockChartResponseDto _$StockChartResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'StockChartResponseDto',
  json,
  ($checkedConvert) {
    final val = StockChartResponseDto(
      ticker: $checkedConvert('ticker', (v) => v as String?),
      status: $checkedConvert('status', (v) => v as String?),
      queryCount: $checkedConvert('query_count', (v) => (v as num?)?.toInt()),
      resultsCount: $checkedConvert(
        'results_count',
        (v) => (v as num?)?.toInt(),
      ),
      adjusted: $checkedConvert('adjusted', (v) => v as bool?),
      requestId: $checkedConvert('request_id', (v) => v as String?),
      count: $checkedConvert('count', (v) => (v as num?)?.toInt()),
      results: $checkedConvert(
        'results',
        (v) => (v as List<dynamic>?)
            ?.map((e) => CandleDto.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'queryCount': 'query_count',
    'resultsCount': 'results_count',
    'requestId': 'request_id',
  },
);

Map<String, dynamic> _$StockChartResponseDtoToJson(
  StockChartResponseDto instance,
) => <String, dynamic>{
  'ticker': instance.ticker,
  'status': instance.status,
  'query_count': instance.queryCount,
  'results_count': instance.resultsCount,
  'adjusted': instance.adjusted,
  'request_id': instance.requestId,
  'count': instance.count,
  'results': instance.results,
};
