import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/favorite_stock.dart';

abstract interface class FavoritesRepository {
  Stream<Either<Failure, List<FavoriteStock>>> watchFavorites();

  Stream<Either<Failure, bool>> watchIsFavorite(String ticker);

  Future<Either<Failure, void>> addFavorite(FavoriteStock favorite);

  Future<Either<Failure, void>> removeFavorite(String ticker);
}
