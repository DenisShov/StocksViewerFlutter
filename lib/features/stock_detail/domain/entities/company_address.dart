import 'package:equatable/equatable.dart';

class CompanyAddress extends Equatable {
  const CompanyAddress({this.address1, this.city, this.state, this.postalCode});

  final String? address1;
  final String? city;
  final String? state;
  final String? postalCode;

  @override
  List<Object?> get props => [address1, city, state, postalCode];
}
