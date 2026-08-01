import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/providers/core_providers.dart';
import '../../../favorites/providers/favorites_providers.dart';
import '../../domain/entities/candle.dart';
import '../../domain/entities/period.dart';
import '../../domain/entities/stock_overview.dart';
import '../../providers/stock_detail_providers.dart';
import 'stock_detail_state.dart';

final stockDetailProvider = NotifierProvider.autoDispose
    .family<StockDetailNotifier, StockDetailState, String>(
      StockDetailNotifier.new,
    );

class StockDetailNotifier extends Notifier<StockDetailState> {
  StockDetailNotifier(this._ticker);

  final String _ticker;
  StreamSubscription<Either<Failure, bool>>? _favoriteSubscription;
  bool _storedFavorite = false;

  @override
  StockDetailState build() {
    ref.onDispose(() => _favoriteSubscription?.cancel());
    Future.microtask(() {
      _watchFavorite(_ticker);
      _loadInitial();
    });
    return StockDetailState.initial(_ticker);
  }

  Future<void> _loadInitial() async {
    await Future.wait<void>([_loadOverview(), _loadCandles(state.period)]);
  }

  Future<void> _loadOverview() async {
    state = state.copyWith(
      overview: const SliceLoading(),
      clearBrandingImageUrl: true,
    );
    final result = await ref.read(getStockOverviewProvider).call(state.ticker);
    if (!ref.mounted) return;
    result.match(
      (failure) =>
          state = state.copyWith(overview: SliceError<StockOverview>(failure)),
      (overview) {
        final branding = overview.branding;
        final imageUrl = ref
            .read(brandingUrlResolverProvider)
            .resolve(branding?.iconUrl ?? branding?.logoUrl);
        state = state.copyWith(
          overview: SliceData<StockOverview>(overview),
          brandingImageUrl: imageUrl,
          clearBrandingImageUrl: imageUrl == null,
        );
      },
    );
  }

  Future<void> _loadCandles(Period period) async {
    final generation = state.candlesGeneration + 1;
    state = state.copyWith(
      candles: const SliceLoading(),
      candlesGeneration: generation,
    );
    final result = await ref
        .read(getStockChartDataProvider)
        .call(ticker: state.ticker, period: period);
    if (!ref.mounted) return;
    if (state.candlesGeneration != generation || state.period != period) {
      return;
    }
    result.match(
      (failure) =>
          state = state.copyWith(candles: SliceError<List<Candle>>(failure)),
      (candles) =>
          state = state.copyWith(candles: SliceData<List<Candle>>(candles)),
    );
  }

  void retryAll() {
    state = state.copyWith(
      overview: const SliceLoading(),
      candles: const SliceLoading(),
    );
    _loadInitial();
  }

  void retryCandles() => _loadCandles(state.period);

  void selectPeriod(Period period) {
    if (period == state.period) return;
    state = state.copyWith(period: period);
    _loadCandles(period);
  }

  void toggleAbout() {
    state = state.copyWith(aboutExpanded: !state.aboutExpanded);
  }

  void _watchFavorite(String ticker) {
    _favoriteSubscription = ref
        .read(watchIsFavoriteProvider)
        .call(ticker)
        .listen((result) {
          if (!ref.mounted) return;
          result.match(
            (failure) => state = state.copyWith(
              favoriteStateResolved: true,
              favoriteWriteFailure: failure,
            ),
            (isFavorite) {
              _storedFavorite = isFavorite;
              state = state.copyWith(
                isFavorite: isFavorite,
                favoriteStateResolved: true,
                clearFavoriteWriteFailure: true,
              );
            },
          );
        });
  }

  Future<void> toggleFavorite() async {
    final overviewSlice = state.overview;
    if (overviewSlice is! SliceData<StockOverview>) return;

    final wasFavorite = state.isFavorite;
    final desired = !wasFavorite;
    state = state.copyWith(
      isFavorite: desired,
      clearFavoriteWriteFailure: true,
    );

    final overview = overviewSlice.value;
    final result = await ref
        .read(toggleFavoriteProvider)
        .call(
          isFavorite: wasFavorite,
          ticker: overview.ticker,
          name: overview.name,
          type: overview.type,
          primaryExchange: overview.primaryExchange,
        );

    if (!ref.mounted) return;

    result.match((failure) {
      state = state.copyWith(
        isFavorite: _storedFavorite,
        favoriteWriteFailure: failure,
      );
    }, (_) {});
  }
}
