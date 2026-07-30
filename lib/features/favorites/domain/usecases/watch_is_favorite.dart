import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../repositories/favorites_repository.dart';

/// Watches whether a given ticker is currently a favorite.
///
/// A concrete use case with a single `call` method and no shared base class
/// (Requirement 2 AC 13).
class WatchIsFavorite {
  const WatchIsFavorite(this._repository);

  final FavoritesRepository _repository;

  Stream<Either<Failure, bool>> call(String ticker) =>
      _repository.watchIsFavorite(ticker);
}
