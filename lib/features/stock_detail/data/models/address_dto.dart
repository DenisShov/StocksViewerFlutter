import 'package:json_annotation/json_annotation.dart';

part 'address_dto.g.dart';

/// Data-transfer object for the `address` object nested inside a
/// [StockOverviewResultDto] (Requirement 16 AC 4).
///
/// All four fields are nullable. `fieldRename: FieldRename.snake`
/// converts `postalCode` to `postal_code` automatically, so no field
/// needs an explicit `@JsonKey(name: ...)` override.
@JsonSerializable(checked: true, includeIfNull: true, fieldRename: FieldRename.snake)
class AddressDto {
  const AddressDto({this.address1, this.city, this.state, this.postalCode});

  final String? address1;
  final String? city;
  final String? state;
  final String? postalCode;

  factory AddressDto.fromJson(Map<String, dynamic> json) => _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);
}
