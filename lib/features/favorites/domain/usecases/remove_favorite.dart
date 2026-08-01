import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../repositories/favorites_repository.dart';

class RemoveFavorite {
  const RemoveFavorite(this._repository);

  final FavoritesRepository _repository;

  Future<Either<Failure, void>> call(String ticker) =>
      _repository.removeFavorite(ticker);
}
