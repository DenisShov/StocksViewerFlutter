import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/favorite_stock.dart';
import '../../providers/favorites_providers.dart';
import 'favorites_state.dart';

final favoritesProvider = NotifierProvider<FavoritesNotifier, FavoritesState>(
  FavoritesNotifier.new,
);

class FavoritesNotifier extends Notifier<FavoritesState> {
  StreamSubscription<Either<Failure, List<FavoriteStock>>>? _subscription;

  @override
  FavoritesState build() {
    ref.onDispose(() {
      _subscription?.cancel();
    });
    _subscribe();
    return const FavoritesPending();
  }

  void _subscribe() {
    _subscription = ref.read(watchFavoritesProvider).call().listen((either) {
      either.match(
        (failure) {
          state = FavoritesError(failure);
        },
        (favorites) {
          state = favorites.isEmpty
              ? const FavoritesEmpty()
              : FavoritesLoaded(favorites);
        },
      );
    });
  }

  void retry() {
    _subscription?.cancel();
    state = const FavoritesPending();
    _subscribe();
  }
}
