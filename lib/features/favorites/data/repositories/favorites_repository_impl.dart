import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_mapper.dart';
import '../../../../core/storage/app_database.dart';
import '../../domain/entities/favorite_stock.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_store.dart';

/// Data-layer implementation of [FavoritesRepository].
///
/// Takes the [FavoritesLocalStore] and the [FailureMapper] through its
/// constructor, resolving neither from a provider container nor a service
/// locator (Requirement 2 AC 16). This file has no `flutter_riverpod`,
/// `riverpod`, or `package:flutter/` import, so the data layer stays free of
/// the DI framework (Requirement 2 AC 2).
class FavoritesRepositoryImpl implements FavoritesRepository {
  const FavoritesRepositoryImpl(this._store, this._failureMapper);

  final FavoritesLocalStore _store;
  final FailureMapper _failureMapper;

  /// Wraps [FavoritesLocalStore.watchAll] in `Either`, converting every
  /// stored row into a [FavoriteStock] and any stream failure into a
  /// `Left` emission rather than a stream-level error (Requirement 18
  /// AC 11).
  ///
  /// A plain `.handleError()` on a `Stream<Either<...>>` cannot emit a
  /// replacement `Left` value into the stream; it can only let the stream
  /// terminate with an error or rethrow. An `async*` generator wrapping a
  /// `try`/`catch` around `yield*` catches an error raised by the delegated
  /// stream and lets this generator continue and yield the fallback value,
  /// which is the effect the design's `handleError(...)` shorthand
  /// describes.
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

  /// Wraps [FavoritesLocalStore.watchIsFavorite] in `Either`, converting
  /// any stream failure into a `Left` emission (Requirement 18 AC 11).
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

  /// Upserts [favorite], leaving the stored rows untouched on failure
  /// (Requirement 18 AC 11).
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

  /// Deletes the record for [ticker], leaving the stored rows untouched on
  /// failure (Requirement 18 AC 11).
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
