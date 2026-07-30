import 'package:json_annotation/json_annotation.dart';

part 'branding_dto.g.dart';

/// Data-transfer object for the `branding` object nested inside a
/// [StockOverviewResultDto] (Requirement 16 AC 5).
///
/// Both fields are nullable. `fieldRename: FieldRename.snake` converts
/// `logoUrl` to `logo_url` and `iconUrl` to `icon_url` automatically, so
/// no field needs an explicit `@JsonKey(name: ...)` override.
@JsonSerializable(checked: true, includeIfNull: true, fieldRename: FieldRename.snake)
class BrandingDto {
  const BrandingDto({this.logoUrl, this.iconUrl});

  final String? logoUrl;
  final String? iconUrl;

  factory BrandingDto.fromJson(Map<String, dynamic> json) => _$BrandingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BrandingDtoToJson(this);
}
