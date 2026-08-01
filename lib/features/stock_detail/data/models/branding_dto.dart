import 'package:json_annotation/json_annotation.dart';

part 'branding_dto.g.dart';

@JsonSerializable(
  checked: true,
  includeIfNull: true,
  fieldRename: FieldRename.snake,
)
class BrandingDto {
  const BrandingDto({this.logoUrl, this.iconUrl});

  final String? logoUrl;
  final String? iconUrl;

  factory BrandingDto.fromJson(Map<String, dynamic> json) =>
      _$BrandingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BrandingDtoToJson(this);
}
