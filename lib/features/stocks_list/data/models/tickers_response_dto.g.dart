// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickers_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TickersResponseDto _$TickersResponseDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TickersResponseDto',
      json,
      ($checkedConvert) {
        final val = TickersResponseDto(
          nextUrl: $checkedConvert('next_url', (v) => v as String?),
          requestId: $checkedConvert('request_id', (v) => v as String?),
          count: $checkedConvert('count', (v) => (v as num?)?.toInt()),
          results: $checkedConvert(
            'results',
            (v) => (v as List<dynamic>?)
                ?.map((e) => TickerDto.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'nextUrl': 'next_url', 'requestId': 'request_id'},
    );

Map<String, dynamic> _$TickersResponseDtoToJson(TickersResponseDto instance) =>
    <String, dynamic>{
      'next_url': instance.nextUrl,
      'request_id': instance.requestId,
      'count': instance.count,
      'results': instance.results,
    };
