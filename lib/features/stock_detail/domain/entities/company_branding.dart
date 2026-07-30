import 'package:equatable/equatable.dart';

/// The branding image URLs nested inside a company overview.
///
/// When the overview payload's `branding` object is absent or null, both
/// fields are set to null (Requirement 16 AC 5).
class CompanyBranding extends Equatable {
  const CompanyBranding({this.logoUrl, this.iconUrl});

  final String? logoUrl;
  final String? iconUrl;

  @override
  List<Object?> get props => [logoUrl, iconUrl];
}
