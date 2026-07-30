import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/favorite_stock.dart';

/// The mutually-exclusive screen states of the Favorites_Screen
/// (Requirement 14 AC 5, AC 6, AC 8; Requirement 2 AC 9).
sealed class FavoritesState extends Equatable {
  const FavoritesState();
}

/// Before the first emission of the favorites stream arrives
/// (Requirement 14 AC 5).
class FavoritesPending extends FavoritesState {
  const FavoritesPending();

  @override
  List<Object?> get props => const [];
}

/// The favorites stream emitted zero favorites (Requirement 14 AC 6).
class FavoritesEmpty extends FavoritesState {
  const FavoritesEmpty();

  @override
  List<Object?> get props => const [];
}

/// The favorites stream emitted at least one favorite, in the order
/// produced by the SQL query, not re-sorted in Dart (Requirement 14 AC 3).
class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded(this.favorites);

  final List<FavoriteStock> favorites;

  @override
  List<Object?> get props => [favorites];
}

/// The favorites stream emitted a `Left` (Requirement 14 AC 8).
class FavoritesError extends FavoritesState {
  const FavoritesError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
