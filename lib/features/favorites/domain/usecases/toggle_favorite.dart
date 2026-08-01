import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/favorite_stock.dart';
import '../repositories/favorites_repository.dart';

class ToggleFavorite {
  ToggleFavorite(this._repository);

  final FavoritesRepository _repository;
  Future<void> _writeQueue = Future.value();

  Future<Either<Failure, void>> call({
    required bool isFavorite,
    required String ticker,
    String? name,
    String? type,
    String? primaryExchange,
  }) {
    final completer = Completer<Either<Failure, void>>();
    _writeQueue = _writeQueue.then((_) async {
      try {
        completer.complete(
          await _execute(
            isFavorite: isFavorite,
            ticker: ticker,
            name: name,
            type: type,
            primaryExchange: primaryExchange,
          ),
        );
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }

  Future<Either<Failure, void>> _execute({
    required bool isFavorite,
    required String ticker,
    String? name,
    String? type,
    String? primaryExchange,
  }) {
    if (isFavorite) {
      return _repository.removeFavorite(ticker);
    }

    return _repository.addFavorite(
      FavoriteStock(
        ticker: ticker,
        name: name ?? '',
        type: type ?? '',
        primaryExchange: primaryExchange ?? '',
      ),
    );
  }
}
