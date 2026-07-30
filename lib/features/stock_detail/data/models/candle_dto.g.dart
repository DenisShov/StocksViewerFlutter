// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candle_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandleDto _$CandleDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'CandleDto',
  json,
  ($checkedConvert) {
    final val = CandleDto(
      open: $checkedConvert('o', (v) => (v as num).toDouble()),
      close: $checkedConvert('c', (v) => (v as num).toDouble()),
      high: $checkedConvert('h', (v) => (v as num).toDouble()),
      low: $checkedConvert('l', (v) => (v as num).toDouble()),
      timestampMs: $checkedConvert('t', (v) => (v as num).toInt()),
      volume: $checkedConvert('v', (v) => (v as num?)?.toDouble()),
      volumeWeightedAveragePrice: $checkedConvert(
        'vw',
        (v) => (v as num?)?.toDouble(),
      ),
      transactionCount: $checkedConvert('n', (v) => (v as num?)?.toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'open': 'o',
    'close': 'c',
    'high': 'h',
    'low': 'l',
    'timestampMs': 't',
    'volume': 'v',
    'volumeWeightedAveragePrice': 'vw',
    'transactionCount': 'n',
  },
);

Map<String, dynamic> _$CandleDtoToJson(CandleDto instance) => <String, dynamic>{
  'v': instance.volume,
  'vw': instance.volumeWeightedAveragePrice,
  'o': instance.open,
  'c': instance.close,
  'h': instance.high,
  'l': instance.low,
  't': instance.timestampMs,
  'n': instance.transactionCount,
};
