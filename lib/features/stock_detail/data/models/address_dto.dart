import 'package:json_annotation/json_annotation.dart';

part 'address_dto.g.dart';

@JsonSerializable(
  checked: true,
  includeIfNull: true,
  fieldRename: FieldRename.snake,
)
class AddressDto {
  const AddressDto({this.address1, this.city, this.state, this.postalCode});

  final String? address1;
  final String? city;
  final String? state;
  final String? postalCode;

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);
}
