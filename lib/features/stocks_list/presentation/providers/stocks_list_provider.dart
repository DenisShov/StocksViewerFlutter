import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../providers/stocks_list_providers.dart';
import 'stocks_list_state.dart';

/// Drives the Stocks_List_Screen: the full ticker list, in-list search,
/// forward-only pagination, and pull-to-refresh (Requirement 6, 7, 8).
///
/// `Notifier` only, no `StateNotifier`, `StateNotifierProvider`,
/// `StateProvider`, or `ChangeNotifierProvider` anywhere (Requirement 2 AC
/// 12).
final stocksListProvider = NotifierProvider<StocksListNotifier, StocksListState>(
  StocksListNotifier.new,
);

class StocksListNotifier extends Notifier<StocksListState> {
  Timer? _debounceTimer;

  @override
  StocksListState build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    // Requirement 6 AC 4: first page, page size 50, null cursor.
    Future.microtask(() => _loadFirstPage(query: ''));
    return const StocksListState.initial();
  }

  /// Requirement 7 AC 2: activates search and requests focus at the
  /// screen level; issues no request.
  void openSearch() {
    state = state.copyWith(searchActive: true);
  }

  /// Requirement 7 AC 6: clears the text, deactivates search, dismisses
  /// the keyboard (screen-level concern), and treats the cleared text as
  /// a search text change.
  void closeSearch() {
    state = state.copyWith(searchActive: false, searchText: '');
    onSearchTextChanged('');
  }

  /// Requirement 7 AC 7: restarts a 1000 ms debounce on every call.
  void onSearchTextChanged(String text) {
    state = state.copyWith(searchText: text);
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
      _onDebouncedTextSettled(text);
    });
  }

  /// Requirement 7 AC 8: a debounced text equal to `issuedQuery` issues
  /// nothing and leaves the rendered results in place.
  void _onDebouncedTextSettled(String text) {
    if (text == state.issuedQuery) {
      return;
    }
    _loadFirstPage(query: text);
  }

  /// Requirement 6 AC 8, Requirement 7 AC 15.
  void retryFirstPage() {
    _loadFirstPage(query: state.issuedQuery);
  }

  /// Requirement 6 AC 5: prefetch guard evaluated by the screen from the
  /// last built item index.
  void loadNextPage() {
    final phase = state.phase;
    if (phase is! ListContent) {
      return;
    }
    if (phase.nextCursor == null || phase.append is! AppendIdle) {
      return;
    }
    _loadPage(cursor: phase.nextCursor);
  }

  /// Requirement 6 AC 11: retries the failed page with the same cursor.
  void retryAppend() {
    final phase = state.phase;
    if (phase is! ListContent || phase.append is! AppendError) {
      return;
    }
    _loadPage(cursor: phase.nextCursor);
  }

  /// Requirement 8 AC 3.
  void onRefreshDrag(double pixels) {
    if (state.refresh is! RefreshIdle) {
      return;
    }
    if (state.phase is! ListContent && state.phase is! ListEmpty) {
      return;
    }
    state = state.copyWith(
      refresh: RefreshIdle(dragProgress: (pixels / 80).clamp(0.0, 1.0)),
    );
  }

  /// Requirement 8 AC 1, AC 2, AC 8.
  void onRefreshRelease(double pixels) {
    final atTop =
        state.phase is ListContent || state.phase is ListEmpty;
    if (pixels >= 80 && atTop && state.refresh is RefreshIdle) {
      _refresh();
    } else {
      state = state.copyWith(refresh: const RefreshIdle(dragProgress: 0.0));
    }
  }

  Future<void> _loadFirstPage({required String query}) async {
    final generation = state.generation + 1;
    state = state.copyWith(
      phase: const ListLoadingFirstPage(),
      issuedQuery: query,
      generation: generation,
    );

    final result = await ref
        .read(getStocksPageProvider)
        .call(query: query, cursor: null);

    // Requirement 7 AC 14: stale-response guard.
    if (state.generation != generation) {
      return;
    }

    result.match(
      (failure) {
        state = state.copyWith(phase: ListFirstPageError(failure));
      },
      (page) {
        state = state.copyWith(
          phase: page.items.isEmpty
              ? const ListEmpty()
              : ListContent(
                  items: page.items,
                  nextCursor: page.nextCursor,
                  append: const AppendIdle(),
                ),
        );
      },
    );
  }

  Future<void> _loadPage({required String? cursor}) async {
    final phase = state.phase;
    if (phase is! ListContent) {
      return;
    }
    // Synchronous transition before the `await` so a burst of scroll
    // notifications cannot double-issue (Requirement 6 AC 5).
    state = state.copyWith(
      phase: ListContent(
        items: phase.items,
        nextCursor: phase.nextCursor,
        append: const AppendLoading(),
      ),
    );

    final query = state.issuedQuery;
    final result = await ref
        .read(getStocksPageProvider)
        .call(query: query, cursor: cursor);

    final currentPhase = state.phase;
    if (currentPhase is! ListContent || query != state.issuedQuery) {
      return;
    }

    result.match(
      (failure) {
        state = state.copyWith(
          phase: ListContent(
            items: currentPhase.items,
            nextCursor: currentPhase.nextCursor,
            append: AppendError(failure),
          ),
        );
      },
      (page) {
        // Requirement 6 AC 16: append in the order received.
        state = state.copyWith(
          phase: ListContent(
            items: [...currentPhase.items, ...page.items],
            nextCursor: page.nextCursor,
            append: const AppendIdle(),
          ),
        );
      },
    );
  }

  Future<void> _refresh() async {
    final generation = state.generation + 1;
    state = state.copyWith(
      refresh: const RefreshInFlight(),
      generation: generation,
    );

    final query = state.issuedQuery;
    final result = await ref
        .read(getStocksPageProvider)
        .call(query: query, cursor: null);

    // Requirement 7 AC 14: the same stale-response guard covers refresh.
    if (state.generation != generation) {
      return;
    }

    result.match(
      (Failure failure) {
        state = state.copyWith(
          phase: ListFirstPageError(failure),
          refresh: const RefreshIdle(dragProgress: 0.0),
        );
      },
      (page) {
        state = state.copyWith(
          phase: page.items.isEmpty
              ? const ListEmpty()
              : ListContent(
                  items: page.items,
                  nextCursor: page.nextCursor,
                  append: const AppendIdle(),
                ),
          refresh: const RefreshIdle(dragProgress: 0.0),
        );
      },
    );
  }
}
