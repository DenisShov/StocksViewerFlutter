import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart' show failureMapperProvider;
import '../../../core/storage/app_database.dart';
import '../data/datasources/favorites_local_store.dart';
import '../data/repositories/favorites_repository_impl.dart';
import '../domain/repositories/favorites_repository.dart';
import '../domain/usecases/add_favorite.dart';
import '../domain/usecases/remove_favorite.dart';
import '../domain/usecases/watch_favorites.dart';
import '../domain/usecases/watch_is_favorite.dart';

/// The only place in the `favorites` feature that constructs the database,
/// the local store, the repository, and the four use cases (Requirement 2
/// AC 3, AC 16). No other file in this feature declares a provider
/// (Requirement 2 AC 5).
///
/// Every provider here is a plain, hand-written `Provider` constructor
/// (Requirement 2 AC 17). `Provider` values are singletons within their
/// `ProviderContainer`/`ProviderScope`, so `appDatabaseProvider` constructs
/// exactly one `AppDatabase` for the lifetime of that scope as long as no
/// other file also calls `AppDatabase()` directly.
final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

final favoritesLocalStoreProvider = Provider<FavoritesLocalStore>(
  (ref) => FavoritesLocalStore(ref.watch(appDatabaseProvider)),
);

/// `failureMapperProvider` is declared once, in
/// `lib/core/providers/core_providers.dart`, and read from here rather
/// than redeclared, since `FailureMapper` is a cross-feature core utility
/// with no per-feature state (Requirement 2 AC 11).
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
