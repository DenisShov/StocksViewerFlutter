import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/favorite_stock.dart';
import '../repositories/favorites_repository.dart';

/// Watches every persisted favorite stock.
///
/// A concrete use case with a single `call` method and no shared base class
/// (Requirement 2 AC 13).
class WatchFavorites {
  const WatchFavorites(this._repository);

  final FavoritesRepository _repository;

  Stream<Either<Failure, List<FavoriteStock>>> call() =>
      _repository.watchFavorites();
}
