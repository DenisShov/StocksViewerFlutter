import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stocks_viewer_flutter/core/error/failure.dart';
import 'package:stocks_viewer_flutter/features/favorites/domain/entities/favorite_stock.dart';
import 'package:stocks_viewer_flutter/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:stocks_viewer_flutter/features/favorites/domain/usecases/watch_favorites.dart';
import 'package:stocks_viewer_flutter/features/favorites/presentation/providers/favorites_provider.dart';
import 'package:stocks_viewer_flutter/features/favorites/presentation/providers/favorites_state.dart';
import 'package:stocks_viewer_flutter/features/favorites/providers/favorites_providers.dart';

void main() {
  late _StreamingFavoritesRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _StreamingFavoritesRepository();
    container = ProviderContainer(
      overrides: [
        watchFavoritesProvider.overrideWithValue(WatchFavorites(repository)),
      ],
    );
    addTearDown(() async {
      container.dispose();
      await repository.close();
    });
  });

  test(
    'maps favorite stream emissions to empty, loaded, and error states',
    () async {
      expect(container.read(favoritesProvider), const FavoritesPending());

      repository.emit(const Right([]));
      await _flush();
      expect(container.read(favoritesProvider), const FavoritesEmpty());

      const tesla = FavoriteStock(
        ticker: 'TSLA',
        name: 'Tesla, Inc.',
        type: 'CS',
        primaryExchange: 'XNAS',
      );
      repository.emit(const Right([tesla]));
      await _flush();
      expect(container.read(favoritesProvider), const FavoritesLoaded([tesla]));

      repository.emit(const Left(NetworkFailure()));
      await _flush();
      expect(
        container.read(favoritesProvider),
        const FavoritesError(NetworkFailure()),
      );
    },
  );

  test('retry replaces the subscription and returns to pending', () async {
    container.read(favoritesProvider);
    repository.emit(const Left(GeneralFailure()));
    await _flush();

    container.read(favoritesProvider.notifier).retry();

    expect(container.read(favoritesProvider), const FavoritesPending());
    expect(repository.watchCount, 2);
  });
}

Future<void> _flush() => Future<void>.delayed(Duration.zero);

class _StreamingFavoritesRepository implements FavoritesRepository {
  final _controller =
      StreamController<Either<Failure, List<FavoriteStock>>>.broadcast();
  int watchCount = 0;

  void emit(Either<Failure, List<FavoriteStock>> value) =>
      _controller.add(value);

  Future<void> close() => _controller.close();

  @override
  Stream<Either<Failure, List<FavoriteStock>>> watchFavorites() {
    watchCount++;
    return _controller.stream;
  }

  @override
  Future<Either<Failure, void>> addFavorite(FavoriteStock favorite) async =>
      const Right(null);

  @override
  Future<Either<Failure, void>> removeFavorite(String ticker) async =>
      const Right(null);

  @override
  Stream<Either<Failure, bool>> watchIsFavorite(String ticker) =>
      const Stream.empty();
}
