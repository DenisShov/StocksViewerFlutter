// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDto _$AddressDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AddressDto', json, ($checkedConvert) {
      final val = AddressDto(
        address1: $checkedConvert('address1', (v) => v as String?),
        city: $checkedConvert('city', (v) => v as String?),
        state: $checkedConvert('state', (v) => v as String?),
        postalCode: $checkedConvert('postal_code', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'postalCode': 'postal_code'});

Map<String, dynamic> _$AddressDtoToJson(AddressDto instance) =>
    <String, dynamic>{
      'address1': instance.address1,
      'city': instance.city,
      'state': instance.state,
      'postal_code': instance.postalCode,
    };
