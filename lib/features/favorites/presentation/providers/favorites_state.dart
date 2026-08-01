import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/favorite_stock.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();
}

class FavoritesPending extends FavoritesState {
  const FavoritesPending();

  @override
  List<Object?> get props => const [];
}

class FavoritesEmpty extends FavoritesState {
  const FavoritesEmpty();

  @override
  List<Object?> get props => const [];
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded(this.favorites);

  final List<FavoriteStock> favorites;

  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  const FavoritesError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
