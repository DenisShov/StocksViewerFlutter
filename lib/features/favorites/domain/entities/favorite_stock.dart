import 'package:equatable/equatable.dart';

class FavoriteStock extends Equatable {
  const FavoriteStock({
    required this.ticker,
    required this.name,
    required this.type,
    required this.primaryExchange,
  });

  final String ticker;
  final String name;
  final String type;
  final String primaryExchange;

  @override
  List<Object?> get props => [ticker, name, type, primaryExchange];
}
