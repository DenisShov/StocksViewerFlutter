import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart' show failureMapperProvider;
import '../../../core/storage/app_database.dart';
import '../data/datasources/favorites_local_store.dart';
import '../data/repositories/favorites_repository_impl.dart';
import '../domain/repositories/favorites_repository.dart';
import '../domain/usecases/add_favorite.dart';
import '../domain/usecases/remove_favorite.dart';
import '../domain/usecases/toggle_favorite.dart';
import '../domain/usecases/watch_favorites.dart';
import '../domain/usecases/watch_is_favorite.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => unawaited(database.close()));
  return database;
});

final favoritesLocalStoreProvider = Provider<FavoritesLocalStore>(
  (ref) => FavoritesLocalStore(ref.watch(appDatabaseProvider)),
);

final favoritesRepositoryProvider = Provider<FavoritesRepository>(
  (ref) => FavoritesRepositoryImpl(
    ref.watch(favoritesLocalStoreProvider),
    ref.watch(failureMapperProvider),
  ),
);

final watchFavoritesProvider = Provider<WatchFavorites>(
  (ref) => WatchFavorites(ref.watch(favoritesRepositoryProvider)),
);

final watchIsFavoriteProvider = Provider<WatchIsFavorite>(
  (ref) => WatchIsFavorite(ref.watch(favoritesRepositoryProvider)),
);

final addFavoriteProvider = Provider<AddFavorite>(
  (ref) => AddFavorite(ref.watch(favoritesRepositoryProvider)),
);

final removeFavoriteProvider = Provider<RemoveFavorite>(
  (ref) => RemoveFavorite(ref.watch(favoritesRepositoryProvider)),
);

final toggleFavoriteProvider = Provider<ToggleFavorite>(
  (ref) => ToggleFavorite(ref.watch(favoritesRepositoryProvider)),
);
