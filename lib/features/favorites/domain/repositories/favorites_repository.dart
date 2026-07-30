import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/favorite_stock.dart';

/// The domain boundary for reading and writing persisted favorite stocks.
///
/// Both stream-returning methods carry the `Either` wrapper so that a
/// local-store failure has somewhere to go, correcting the Reference_Template
/// defect of dropping the wrapper on stream-returning repository methods
/// (Requirement 2 AC 14, Requirement 18 AC 11).
abstract interface class FavoritesRepository {
  Stream<Either<Failure, List<FavoriteStock>>> watchFavorites();

  Stream<Either<Failure, bool>> watchIsFavorite(String ticker);

  Future<Either<Failure, void>> addFavorite(FavoriteStock favorite);

  Future<Either<Failure, void>> removeFavorite(String ticker);
}
