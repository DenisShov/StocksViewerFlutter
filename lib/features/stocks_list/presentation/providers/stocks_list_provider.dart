import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../providers/stocks_list_providers.dart';
import 'stocks_list_state.dart';

final stocksListProvider =
    NotifierProvider<StocksListNotifier, StocksListState>(
      StocksListNotifier.new,
    );

class StocksListNotifier extends Notifier<StocksListState> {
  Timer? _debounceTimer;

  @override
  StocksListState build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    Future.microtask(() => _loadFirstPage(query: ''));
    return const StocksListState.initial();
  }

  void openSearch() {
    state = state.copyWith(searchActive: true);
  }

  void closeSearch() {
    state = state.copyWith(searchActive: false, searchText: '');
    onSearchTextChanged('');
  }

  void onSearchTextChanged(String text) {
    state = state.copyWith(searchText: text);
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
      _onDebouncedTextSettled(text);
    });
  }

  void _onDebouncedTextSettled(String text) {
    if (text == state.issuedQuery) {
      return;
    }
    _loadFirstPage(query: text);
  }

  void retryFirstPage() {
    _loadFirstPage(query: state.issuedQuery);
  }

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

  void retryAppend() {
    final phase = state.phase;
    if (phase is! ListContent || phase.append is! AppendError) {
      return;
    }
    _loadPage(cursor: phase.nextCursor);
  }

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

  void onRefreshRelease(double pixels) {
    final atTop = state.phase is ListContent || state.phase is ListEmpty;
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
