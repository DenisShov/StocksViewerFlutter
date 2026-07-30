import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/favorite_stock.dart';
import '../repositories/favorites_repository.dart';

/// Adds or replaces a favorite stock.
///
/// A concrete use case with a single `call` method and no shared base class
/// (Requirement 2 AC 13).
class AddFavorite {
  const AddFavorite(this._repository);

  final FavoritesRepository _repository;

  Future<Either<Failure, void>> call(FavoriteStock favorite) =>
      _repository.addFavorite(favorite);
}
