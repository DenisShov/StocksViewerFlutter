import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../repositories/favorites_repository.dart';

class WatchIsFavorite {
  const WatchIsFavorite(this._repository);

  final FavoritesRepository _repository;

  Stream<Either<Failure, bool>> call(String ticker) =>
      _repository.watchIsFavorite(ticker);
}
