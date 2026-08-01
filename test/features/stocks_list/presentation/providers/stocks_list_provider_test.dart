import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stocks_viewer_flutter/core/error/failure.dart';
import 'package:stocks_viewer_flutter/features/stocks_list/domain/entities/stock_summary.dart';
import 'package:stocks_viewer_flutter/features/stocks_list/domain/entities/ticker_page.dart';
import 'package:stocks_viewer_flutter/features/stocks_list/domain/repositories/stocks_list_repository.dart';
import 'package:stocks_viewer_flutter/features/stocks_list/domain/usecases/get_stocks_page.dart';
import 'package:stocks_viewer_flutter/features/stocks_list/presentation/providers/stocks_list_provider.dart';
import 'package:stocks_viewer_flutter/features/stocks_list/presentation/providers/stocks_list_state.dart';
import 'package:stocks_viewer_flutter/features/stocks_list/providers/stocks_list_providers.dart';

void main() {
  late _ControllableStocksRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _ControllableStocksRepository();
    container = ProviderContainer(
      overrides: [
        getStocksPageProvider.overrideWithValue(GetStocksPage(repository)),
      ],
    );
    addTearDown(container.dispose);
  });

  test('loads the first page and appends the next page only once', () async {
    container.read(stocksListProvider);
    await _waitForCalls(repository, 1);

    expect(repository.calls.single, const _PageCall(query: '', cursor: null));
    repository.complete(
      0,
      const Right(
        TickerPage(
          items: [StockSummary(ticker: 'A', name: 'Agilent')],
          nextCursor: 'page-2',
        ),
      ),
    );
    await _flush();

    final firstPage = container.read(stocksListProvider).phase as ListContent;
    expect(firstPage.items.map((item) => item.ticker), ['A']);

    final notifier = container.read(stocksListProvider.notifier);
    notifier.loadNextPage();
    notifier.loadNextPage();
    await _waitForCalls(repository, 2);

    expect(repository.calls[1], const _PageCall(query: '', cursor: 'page-2'));
    expect(
      (container.read(stocksListProvider).phase as ListContent).append,
      isA<AppendLoading>(),
    );

    repository.complete(
      1,
      const Right(
        TickerPage(
          items: [StockSummary(ticker: 'AA', name: 'Alcoa')],
          nextCursor: null,
        ),
      ),
    );
    await _flush();

    final completed = container.read(stocksListProvider).phase as ListContent;
    expect(completed.items.map((item) => item.ticker), ['A', 'AA']);
    expect(completed.nextCursor, isNull);

    notifier.loadNextPage();
    await _flush();
    expect(repository.calls, hasLength(2));
  });

  test(
    'keeps loaded rows when append fails and retries the same cursor',
    () async {
      container.read(stocksListProvider);
      await _waitForCalls(repository, 1);
      repository.complete(
        0,
        const Right(
          TickerPage(
            items: [StockSummary(ticker: 'A')],
            nextCursor: 'next',
          ),
        ),
      );
      await _flush();

      final notifier = container.read(stocksListProvider.notifier);
      notifier.loadNextPage();
      await _waitForCalls(repository, 2);
      repository.complete(1, const Left(NetworkFailure()));
      await _flush();

      final failed = container.read(stocksListProvider).phase as ListContent;
      expect(failed.items.map((item) => item.ticker), ['A']);
      expect(failed.append, isA<AppendError>());

      notifier.retryAppend();
      await _waitForCalls(repository, 3);
      expect(repository.calls[2].cursor, 'next');
    },
  );

  test('discards a superseded first-page response', () async {
    container.read(stocksListProvider);
    await _waitForCalls(repository, 1);

    final notifier = container.read(stocksListProvider.notifier);
    notifier.retryFirstPage();
    await _waitForCalls(repository, 2);

    repository.complete(
      1,
      const Right(
        TickerPage(items: [StockSummary(ticker: 'NEW')], nextCursor: null),
      ),
    );
    await _flush();
    repository.complete(
      0,
      const Right(
        TickerPage(items: [StockSummary(ticker: 'STALE')], nextCursor: null),
      ),
    );
    await _flush();

    final phase = container.read(stocksListProvider).phase as ListContent;
    expect(phase.items.map((item) => item.ticker), ['NEW']);
  });
}

Future<void> _waitForCalls(
  _ControllableStocksRepository repository,
  int count,
) async {
  for (
    var attempt = 0;
    attempt < 20 && repository.calls.length < count;
    attempt++
  ) {
    await _flush();
  }
  expect(repository.calls, hasLength(count));
}

Future<void> _flush() => Future<void>.delayed(Duration.zero);

class _ControllableStocksRepository implements StocksListRepository {
  final calls = <_PageCall>[];
  final _responses = <Completer<Either<Failure, TickerPage>>>[];

  @override
  Future<Either<Failure, TickerPage>> getPage({
    required String query,
    String? cursor,
  }) {
    calls.add(_PageCall(query: query, cursor: cursor));
    final response = Completer<Either<Failure, TickerPage>>();
    _responses.add(response);
    return response.future;
  }

  void complete(int index, Either<Failure, TickerPage> response) {
    _responses[index].complete(response);
  }
}

class _PageCall {
  const _PageCall({required this.query, required this.cursor});

  final String query;
  final String? cursor;

  @override
  bool operator ==(Object other) =>
      other is _PageCall && other.query == query && other.cursor == cursor;

  @override
  int get hashCode => Object.hash(query, cursor);
}
