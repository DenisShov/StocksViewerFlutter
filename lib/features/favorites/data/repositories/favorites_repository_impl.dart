import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_mapper.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/entities/favorite_stock.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_store.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl(this._store, this._failureMapper);

  final FavoritesLocalStore _store;
  final FailureMapper _failureMapper;

  @override
  Stream<Either<Failure, List<FavoriteStock>>> watchFavorites() async* {
    try {
      yield* _store.watchAll().map(
        (rows) => Right<Failure, List<FavoriteStock>>(
          rows
              .map(
                (row) => FavoriteStock(
                  ticker: row.ticker,
                  name: row.name,
                  type: row.type,
                  primaryExchange: row.primaryExchange,
                ),
              )
              .toList(),
        ),
      );
    } catch (error) {
      yield Left(_failureMapper.fromException(error));
    }
  }

  @override
  Stream<Either<Failure, bool>> watchIsFavorite(String ticker) async* {
    try {
      yield* _store
          .watchIsFavorite(ticker)
          .map<Either<Failure, bool>>(Right.new);
    } catch (error) {
      yield Left(_failureMapper.fromException(error));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(FavoriteStock favorite) async {
    try {
      await _store.upsert(
        FavoriteStockRow(
          ticker: favorite.ticker,
          name: favorite.name,
          type: favorite.type,
          primaryExchange: favorite.primaryExchange,
        ),
      );
      return const Right(null);
    } catch (error) {
      return Left(_failureMapper.fromException(error));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String ticker) async {
    try {
      await _store.deleteByTicker(ticker);
      return const Right(null);
    } catch (error) {
      return Left(_failureMapper.fromException(error));
    }
  }
}
