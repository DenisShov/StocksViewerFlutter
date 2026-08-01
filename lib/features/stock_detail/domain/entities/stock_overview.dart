import 'package:equatable/equatable.dart';

import 'company_address.dart';
import 'company_branding.dart';

class StockOverview extends Equatable {
  const StockOverview({
    required this.ticker,
    this.name,
    this.market,
    this.locale,
    this.type,
    this.active,
    this.currencyName,
    this.description,
    this.marketCap,
    this.totalEmployees,
    this.listDate,
    this.homepageUrl,
    this.phoneNumber,
    this.sicCode,
    this.sicDescription,
    this.tickerRoot,
    this.shareClassSharesOutstanding,
    this.weightedSharesOutstanding,
    this.roundLot,
    this.primaryExchange,
    this.cik,
    this.address,
    this.branding,
  });

  final String ticker;
  final String? name;
  final String? market;
  final String? locale;
  final String? type;
  final bool? active;
  final String? currencyName;
  final String? description;
  final double? marketCap;
  final int? totalEmployees;
  final String? listDate;
  final String? homepageUrl;
  final String? phoneNumber;
  final String? sicCode;
  final String? sicDescription;
  final String? tickerRoot;
  final double? shareClassSharesOutstanding;
  final double? weightedSharesOutstanding;
  final int? roundLot;
  final String? primaryExchange;
  final String? cik;
  final CompanyAddress? address;
  final CompanyBranding? branding;

  @override
  List<Object?> get props => [
    ticker,
    name,
    market,
    locale,
    type,
    active,
    currencyName,
    description,
    marketCap,
    totalEmployees,
    listDate,
    homepageUrl,
    phoneNumber,
    sicCode,
    sicDescription,
    tickerRoot,
    shareClassSharesOutstanding,
    weightedSharesOutstanding,
    roundLot,
    primaryExchange,
    cik,
    address,
    branding,
  ];
}
