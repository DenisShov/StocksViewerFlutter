// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_overview_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockOverviewResultDto _$StockOverviewResultDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'StockOverviewResultDto',
  json,
  ($checkedConvert) {
    final val = StockOverviewResultDto(
      ticker: $checkedConvert('ticker', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String?),
      market: $checkedConvert('market', (v) => v as String?),
      locale: $checkedConvert('locale', (v) => v as String?),
      type: $checkedConvert('type', (v) => v as String?),
      active: $checkedConvert('active', (v) => v as bool?),
      currencyName: $checkedConvert('currency_name', (v) => v as String?),
      description: $checkedConvert('description', (v) => v as String?),
      marketCap: $checkedConvert('market_cap', (v) => (v as num?)?.toDouble()),
      totalEmployees: $checkedConvert(
        'total_employees',
        (v) => (v as num?)?.toInt(),
      ),
      listDate: $checkedConvert('list_date', (v) => v as String?),
      homepageUrl: $checkedConvert('homepage_url', (v) => v as String?),
      phoneNumber: $checkedConvert('phone_number', (v) => v as String?),
      sicCode: $checkedConvert('sic_code', (v) => v as String?),
      sicDescription: $checkedConvert('sic_description', (v) => v as String?),
      tickerRoot: $checkedConvert('ticker_root', (v) => v as String?),
      shareClassSharesOutstanding: $checkedConvert(
        'share_class_shares_outstanding',
        (v) => (v as num?)?.toDouble(),
      ),
      weightedSharesOutstanding: $checkedConvert(
        'weighted_shares_outstanding',
        (v) => (v as num?)?.toDouble(),
      ),
      roundLot: $checkedConvert('round_lot', (v) => (v as num?)?.toInt()),
      primaryExchange: $checkedConvert('primary_exchange', (v) => v as String?),
      cik: $checkedConvert('cik', (v) => v as String?),
      address: $checkedConvert(
        'address',
        (v) =>
            v == null ? null : AddressDto.fromJson(v as Map<String, dynamic>),
      ),
      branding: $checkedConvert(
        'branding',
        (v) =>
            v == null ? null : BrandingDto.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'currencyName': 'currency_name',
    'marketCap': 'market_cap',
    'totalEmployees': 'total_employees',
    'listDate': 'list_date',
    'homepageUrl': 'homepage_url',
    'phoneNumber': 'phone_number',
    'sicCode': 'sic_code',
    'sicDescription': 'sic_description',
    'tickerRoot': 'ticker_root',
    'shareClassSharesOutstanding': 'share_class_shares_outstanding',
    'weightedSharesOutstanding': 'weighted_shares_outstanding',
    'roundLot': 'round_lot',
    'primaryExchange': 'primary_exchange',
  },
);

Map<String, dynamic> _$StockOverviewResultDtoToJson(
  StockOverviewResultDto instance,
) => <String, dynamic>{
  'ticker': instance.ticker,
  'name': instance.name,
  'market': instance.market,
  'locale': instance.locale,
  'type': instance.type,
  'active': instance.active,
  'currency_name': instance.currencyName,
  'description': instance.description,
  'market_cap': instance.marketCap,
  'total_employees': instance.totalEmployees,
  'list_date': instance.listDate,
  'homepage_url': instance.homepageUrl,
  'phone_number': instance.phoneNumber,
  'sic_code': instance.sicCode,
  'sic_description': instance.sicDescription,
  'ticker_root': instance.tickerRoot,
  'share_class_shares_outstanding': instance.shareClassSharesOutstanding,
  'weighted_shares_outstanding': instance.weightedSharesOutstanding,
  'round_lot': instance.roundLot,
  'primary_exchange': instance.primaryExchange,
  'cik': instance.cik,
  'address': instance.address,
  'branding': instance.branding,
};
