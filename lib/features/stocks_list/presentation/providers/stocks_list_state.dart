import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/stock_summary.dart';

/// The mutually-exclusive screen phases of the Stocks_List_Screen
/// (Requirement 2 AC 9).
sealed class StocksListPhase extends Equatable {
  const StocksListPhase();
}

/// 10 Shimmer_Block skeleton rows, no stock rows (Requirement 6 AC 6).
class ListLoadingFirstPage extends StocksListPhase {
  const ListLoadingFirstPage();

  @override
  List<Object?> get props => const [];
}

/// At least one row loaded.
class ListContent extends StocksListPhase {
  const ListContent({
    required this.items,
    required this.nextCursor,
    required this.append,
  });

  final List<StockSummary> items;

  /// `null`: exhausted, no further requests (Requirement 6 AC 12).
  final String? nextCursor;
  final AppendStatus append;

  @override
  List<Object?> get props => [items, nextCursor, append];
}

/// First page succeeded with zero items (Requirement 6 AC 14, Requirement 7
/// AC 12).
class ListEmpty extends StocksListPhase {
  const ListEmpty();

  @override
  List<Object?> get props => const [];
}

/// First page failed (Requirement 6 AC 7, Requirement 7 AC 13, Requirement 8
/// AC 6).
class ListFirstPageError extends StocksListPhase {
  const ListFirstPageError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

/// The status of a subsequent-page request appended to an already-loaded
/// list.
sealed class AppendStatus extends Equatable {
  const AppendStatus();
}

class AppendIdle extends AppendStatus {
  const AppendIdle();

  @override
  List<Object?> get props => const [];
}

/// Trailing spinner (Requirement 6 AC 9).
class AppendLoading extends AppendStatus {
  const AppendLoading();

  @override
  List<Object?> get props => const [];
}

/// Retry row (Requirement 6 AC 10).
class AppendError extends AppendStatus {
  const AppendError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

/// The status of the pull-to-refresh gesture.
sealed class RefreshStatus extends Equatable {
  const RefreshStatus();
}

class RefreshIdle extends RefreshStatus {
  const RefreshIdle({this.dragProgress = 0.0});

  /// 0.0..1.0, drag distance / 80 (Requirement 8 AC 3).
  final double dragProgress;

  @override
  List<Object?> get props => [dragProgress];
}

class RefreshInFlight extends RefreshStatus {
  const RefreshInFlight();

  @override
  List<Object?> get props => const [];
}

/// The full presentation state of the Stocks_List_Screen.
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

  /// Live text field content.
  final String searchText;

  /// The query of the most recently issued first-page request; `''`
  /// initially.
  final String issuedQuery;

  /// Monotonic request token for the stale-response guard.
  final int generation;

  /// The initial state before the first page request is issued
  /// (Requirement 6 AC 4).
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
