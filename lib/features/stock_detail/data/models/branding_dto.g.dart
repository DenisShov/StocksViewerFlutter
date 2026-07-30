// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branding_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandingDto _$BrandingDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BrandingDto', json, ($checkedConvert) {
      final val = BrandingDto(
        logoUrl: $checkedConvert('logo_url', (v) => v as String?),
        iconUrl: $checkedConvert('icon_url', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'logoUrl': 'logo_url', 'iconUrl': 'icon_url'});

Map<String, dynamic> _$BrandingDtoToJson(BrandingDto instance) =>
    <String, dynamic>{
      'logo_url': instance.logoUrl,
      'icon_url': instance.iconUrl,
    };
