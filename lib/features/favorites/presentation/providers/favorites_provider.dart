import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/favorite_stock.dart';
import '../../providers/favorites_providers.dart';
import 'favorites_state.dart';

/// Drives the Favorites_Screen (Requirement 14).
///
/// `Notifier` only, no `StateNotifier`, `StateNotifierProvider`,
/// `StateProvider`, or `ChangeNotifierProvider` anywhere (Requirement 2 AC
/// 12).
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

  /// Requirement 14 AC 4: subscribes exactly once and holds exactly one
  /// subscription while mounted.
  void _subscribe() {
    _subscription = ref
        .read(watchFavoritesProvider)
        .call()
        .listen((either) {
          // Requirement 14 AC 9: each emission replaces the state with no
          // user-initiated reload.
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

  /// Requirement 14 AC 10: cancels the existing subscription, sets
  /// `FavoritesPending`, and re-subscribes.
  void retry() {
    _subscription?.cancel();
    state = const FavoritesPending();
    _subscribe();
  }
}
