import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/favorite_stock.dart';
import '../repositories/favorites_repository.dart';

class WatchFavorites {
  const WatchFavorites(this._repository);

  final FavoritesRepository _repository;

  Stream<Either<Failure, List<FavoriteStock>>> call() =>
      _repository.watchFavorites();
}
