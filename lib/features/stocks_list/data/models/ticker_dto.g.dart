// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticker_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TickerDto _$TickerDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'TickerDto',
  json,
  ($checkedConvert) {
    final val = TickerDto(
      ticker: $checkedConvert('ticker', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String?),
      market: $checkedConvert('market', (v) => v as String?),
      locale: $checkedConvert('locale', (v) => v as String?),
      primaryExchange: $checkedConvert('primary_exchange', (v) => v as String?),
      type: $checkedConvert('type', (v) => v as String?),
      active: $checkedConvert('active', (v) => v as bool?),
      currencyName: $checkedConvert('currency_name', (v) => v as String?),
      cik: $checkedConvert('cik', (v) => v as String?),
      compositeFigi: $checkedConvert('composite_figi', (v) => v as String?),
      shareClassFigi: $checkedConvert('share_class_figi', (v) => v as String?),
      lastUpdatedUtc: $checkedConvert('last_updated_utc', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'primaryExchange': 'primary_exchange',
    'currencyName': 'currency_name',
    'compositeFigi': 'composite_figi',
    'shareClassFigi': 'share_class_figi',
    'lastUpdatedUtc': 'last_updated_utc',
  },
);

Map<String, dynamic> _$TickerDtoToJson(TickerDto instance) => <String, dynamic>{
  'ticker': instance.ticker,
  'name': instance.name,
  'market': instance.market,
  'locale': instance.locale,
  'primary_exchange': instance.primaryExchange,
  'type': instance.type,
  'active': instance.active,
  'currency_name': instance.currencyName,
  'cik': instance.cik,
  'composite_figi': instance.compositeFigi,
  'share_class_figi': instance.shareClassFigi,
  'last_updated_utc': instance.lastUpdatedUtc,
};
