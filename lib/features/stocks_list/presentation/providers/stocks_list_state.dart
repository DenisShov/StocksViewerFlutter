import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/stock_summary.dart';

sealed class StocksListPhase extends Equatable {
  const StocksListPhase();
}

class ListLoadingFirstPage extends StocksListPhase {
  const ListLoadingFirstPage();

  @override
  List<Object?> get props => const [];
}

class ListContent extends StocksListPhase {
  const ListContent({
    required this.items,
    required this.nextCursor,
    required this.append,
  });

  final List<StockSummary> items;

  final String? nextCursor;
  final AppendStatus append;

  @override
  List<Object?> get props => [items, nextCursor, append];
}

class ListEmpty extends StocksListPhase {
  const ListEmpty();

  @override
  List<Object?> get props => const [];
}

class ListFirstPageError extends StocksListPhase {
  const ListFirstPageError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

sealed class AppendStatus extends Equatable {
  const AppendStatus();
}

class AppendIdle extends AppendStatus {
  const AppendIdle();

  @override
  List<Object?> get props => const [];
}

class AppendLoading extends AppendStatus {
  const AppendLoading();

  @override
  List<Object?> get props => const [];
}

class AppendError extends AppendStatus {
  const AppendError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

sealed class RefreshStatus extends Equatable {
  const RefreshStatus();
}

class RefreshIdle extends RefreshStatus {
  const RefreshIdle({this.dragProgress = 0.0});

  final double dragProgress;

  @override
  List<Object?> get props => [dragProgress];
}

class RefreshInFlight extends RefreshStatus {
  const RefreshInFlight();

  @override
  List<Object?> get props => const [];
}

class StocksListState extends Equatable {
  const StocksListState({
    required this.phase,
    required this.refresh,
    required this.searchActive,
    required this.searchText,
    required this.issuedQuery,
    required this.generation,
  });

  final StocksListPhase phase;
  final RefreshStatus refresh;
  final bool searchActive;

  final String searchText;

  final String issuedQuery;

  final int generation;

  const StocksListState.initial()
    : phase = const ListLoadingFirstPage(),
      refresh = const RefreshIdle(),
      searchActive = false,
      searchText = '',
      issuedQuery = '',
      generation = 0;

  StocksListState copyWith({
    StocksListPhase? phase,
    RefreshStatus? refresh,
    bool? searchActive,
    String? searchText,
    String? issuedQuery,
    int? generation,
  }) {
    return StocksListState(
      phase: phase ?? this.phase,
      refresh: refresh ?? this.refresh,
      searchActive: searchActive ?? this.searchActive,
      searchText: searchText ?? this.searchText,
      issuedQuery: issuedQuery ?? this.issuedQuery,
      generation: generation ?? this.generation,
    );
  }

  @override
  List<Object?> get props => [
    phase,
    refresh,
    searchActive,
    searchText,
    issuedQuery,
    generation,
  ];
}
