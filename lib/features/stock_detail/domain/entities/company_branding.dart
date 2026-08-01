import 'package:equatable/equatable.dart';

class CompanyBranding extends Equatable {
  const CompanyBranding({this.logoUrl, this.iconUrl});

  final String? logoUrl;
  final String? iconUrl;

  @override
  List<Object?> get props => [logoUrl, iconUrl];
}
