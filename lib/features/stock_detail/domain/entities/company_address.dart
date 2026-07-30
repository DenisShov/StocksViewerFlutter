import 'package:equatable/equatable.dart';

/// The postal address nested inside a company overview.
///
/// When the overview payload's `address` object is absent or null, all
/// four fields are set to null (Requirement 16 AC 4).
class CompanyAddress extends Equatable {
  const CompanyAddress({this.address1, this.city, this.state, this.postalCode});

  final String? address1;
  final String? city;
  final String? state;
  final String? postalCode;

  @override
  List<Object?> get props => [address1, city, state, postalCode];
}
