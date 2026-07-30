import 'package:equatable/equatable.dart';

import 'company_address.dart';
import 'company_branding.dart';

/// The full company overview for a single ticker (Requirement 16 AC 3).
///
/// `ticker` is required; the other twenty scalar fields plus the nested
/// [address] and [branding] objects are nullable. `type` holds the raw,
/// unformatted type code; formatting for display happens in the
/// presentation layer via `ValueFormatter.formatType`. `listDate` holds the
/// raw ISO date string; formatting happens via
/// `ValueFormatter.formatListedDate`.
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
