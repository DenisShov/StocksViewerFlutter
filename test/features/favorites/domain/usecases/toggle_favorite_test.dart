import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stocks_viewer_flutter/core/error/failure.dart';
import 'package:stocks_viewer_flutter/features/favorites/domain/entities/favorite_stock.dart';
import 'package:stocks_viewer_flutter/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:stocks_viewer_flutter/features/favorites/domain/usecases/toggle_favorite.dart';

void main() {
  late _RecordingFavoritesRepository repository;
  late ToggleFavorite useCase;

  setUp(() {
    repository = _RecordingFavoritesRepository();
    useCase = ToggleFavorite(repository);
  });

  test('adds a non-favorite while preserving the raw ticker type', () async {
    await useCase(
      isFavorite: false,
      ticker: 'TSLA',
      name: 'Tesla, Inc.',
      type: 'CS',
      primaryExchange: 'XNAS',
    );

    expect(
      repository.added,
      const FavoriteStock(
        ticker: 'TSLA',
        name: 'Tesla, Inc.',
        type: 'CS',
        primaryExchange: 'XNAS',
      ),
    );
    expect(repository.removedTicker, isNull);
  });

  test('removes an existing favorite', () async {
    await useCase(isFavorite: true, ticker: 'TSLA');

    expect(repository.removedTicker, 'TSLA');
    expect(repository.added, isNull);
  });

  test('maps absent optional values to empty persisted strings', () async {
    await useCase(isFavorite: false, ticker: 'ACWI');

    expect(
      repository.added,
      const FavoriteStock(
        ticker: 'ACWI',
        name: '',
        type: '',
        primaryExchange: '',
      ),
    );
  });

  test('serializes rapid favorite writes in invocation order', () async {
    repository.addGate = Completer<void>();

    final add = useCase(isFavorite: false, ticker: 'TSLA');
    await repository.addStarted.future;
    final remove = useCase(isFavorite: true, ticker: 'TSLA');
    await Future<void>.delayed(Duration.zero);

    expect(repository.operations, ['add']);

    repository.addGate!.complete();
    await Future.wait([add, remove]);
    expect(repository.operations, ['add', 'remove']);
  });
}

class _RecordingFavoritesRepository implements FavoritesRepository {
  FavoriteStock? added;
  String? removedTicker;
  Completer<void>? addGate;
  final addStarted = Completer<void>();
  final operations = <String>[];

  @override
  Future<Either<Failure, void>> addFavorite(FavoriteStock favorite) async {
    operations.add('add');
    added = favorite;
    if (!addStarted.isCompleted) addStarted.complete();
    await addGate?.future;
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String ticker) async {
    operations.add('remove');
    removedTicker = ticker;
    return const Right(null);
  }

  @override
  Stream<Either<Failure, List<FavoriteStock>>> watchFavorites() =>
      const Stream.empty();

  @override
  Stream<Either<Failure, bool>> watchIsFavorite(String ticker) =>
      const Stream.empty();
}
