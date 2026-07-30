import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../repositories/favorites_repository.dart';

/// Removes a favorite stock by ticker.
///
/// A concrete use case with a single `call` method and no shared base class
/// (Requirement 2 AC 13).
class RemoveFavorite {
  const RemoveFavorite(this._repository);

  final FavoritesRepository _repository;

  Future<Either<Failure, void>> call(String ticker) =>
      _repository.removeFavorite(ticker);
}
