import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure_message_resolver.dart';
import '../../../../core/ui/app_keys.dart';
import '../../../../core/ui/error_view.dart';
import '../../../../core/ui/paging_retry_row.dart';
import '../../../../core/ui/search_app_bar.dart';
import '../../../../core/ui/shimmer_block.dart';
import '../../../../core/ui/stock_list_card.dart';
import '../../../../core/utils/value_formatter.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/stocks_list_provider.dart';
import '../providers/stocks_list_state.dart';

class StocksListScreen extends ConsumerStatefulWidget {
  const StocksListScreen({super.key});

  @override
  ConsumerState<StocksListScreen> createState() => _StocksListScreenState();
}

class _StocksListScreenState extends ConsumerState<StocksListScreen> {
  static const _paginationThreshold = 1200.0;

  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  final _scrollController = ScrollController();
  double _pullDistance = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.extentAfter <= _paginationThreshold) {
      ref.read(stocksListProvider.notifier).loadNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stocksListProvider);
    final notifier = ref.read(stocksListProvider.notifier);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      key: AppKeys.stocksListScreen,
      appBar: SearchAppBar(
        title: l10n.allStocksTitle,
        searchActive: state.searchActive,
        controller: _searchController,
        focusNode: _searchFocusNode,
        onSearchOpen: () {
          notifier.openSearch();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _searchFocusNode.requestFocus();
          });
        },
        onSearchClose: () {
          _searchController.clear();
          notifier.closeSearch();
          _searchFocusNode.unfocus();
        },
        onSearchTextChanged: notifier.onSearchTextChanged,
      ),
      body: _body(context, state, notifier),
    );
  }

  Widget _body(
    BuildContext context,
    StocksListState state,
    StocksListNotifier notifier,
  ) {
    final l10n = AppLocalizations.of(context);
    final resolver = FailureMessageResolver(l10n);
    final phase = state.phase;

    if (phase is ListLoadingFirstPage) {
      return const _StocksSkeleton();
    }
    if (phase is ListFirstPageError) {
      return ErrorView(
        message: resolver.resolve(phase.failure),
        onRetry: notifier.retryFirstPage,
      );
    }
    if (phase is ListEmpty) {
      return Center(
        child: Text(
          state.issuedQuery.isEmpty
              ? l10n.noStocksAvailableText
              : l10n.noStocksMatchSearchText,
          key: AppKeys.emptyStateMessage,
          textAlign: TextAlign.center,
        ),
      );
    }
    if (phase is! ListContent) return const SizedBox.shrink();

    final trailingItems = phase.append is AppendIdle ? 0 : 1;
    final refreshValue = state.refresh is RefreshInFlight
        ? null
        : (state.refresh as RefreshIdle).dragProgress;

    return Column(
      children: [
        LinearProgressIndicator(
          key: AppKeys.refreshProgressIndicator,
          value: refreshValue,
          minHeight: 4,
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is OverscrollNotification &&
                  notification.metrics.pixels <= 0 &&
                  notification.overscroll < 0) {
                _pullDistance += -notification.overscroll;
                notifier.onRefreshDrag(_pullDistance);
              } else if (notification is ScrollEndNotification) {
                notifier.onRefreshRelease(_pullDistance);
                _pullDistance = 0;
              }
              return false;
            },
            child: ListView.separated(
              key: AppKeys.stocksList,
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              itemCount: phase.items.length + trailingItems,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                if (index < phase.items.length) {
                  final stock = phase.items[index];
                  return StockListCard(
                    key: ValueKey(stock.ticker),
                    ticker: stock.ticker,
                    name: stock.name ?? stock.ticker,
                    type: ValueFormatter.formatType(stock.type ?? ''),
                    onTap: (ticker) => context.push(
                      '/stocks/detail/${Uri.encodeComponent(ticker)}',
                    ),
                  );
                }

                final append = phase.append;
                if (append is AppendLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (append is AppendError) {
                  return PagingRetryRow(
                    message: resolver.resolve(append.failure),
                    onRetry: notifier.retryAppend,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _StocksSkeleton extends StatelessWidget {
  const _StocksSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      key: AppKeys.loadingPlaceholder,
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: 10,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, _) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ShimmerBlock(
          height: 104,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
