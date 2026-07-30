import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/candle.dart';
import '../../domain/entities/period.dart';
import '../../domain/entities/stock_overview.dart';

/// The outcome of one independently-tracked async request.
///
/// The Stock_Detail_Screen holds two [Slice]s side by side in
/// [StockDetailState] (`overview` and `candles`) so that a chart failure
/// never gates the overview and vice versa (Requirement 10, Deliberate
/// Deviation 1).
sealed class Slice<T> extends Equatable {
  const Slice();
}

/// The request has not yet completed.
class SliceLoading<T> extends Slice<T> {
  const SliceLoading();

  @override
  List<Object?> get props => const [];
}

/// The request completed successfully.
class SliceData<T> extends Slice<T> {
  const SliceData(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}

/// The request failed.
class SliceError<T> extends Slice<T> {
  const SliceError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

/// The full presentation state of the Stock_Detail_Screen.
class StockDetailState extends Equatable {
  const StockDetailState({
    required this.ticker,
    required this.overview,
    required this.candles,
    required this.period,
    required this.aboutExpanded,
    required this.isFavorite,
    required this.favoriteStateResolved,
    required this.favoriteWriteFailure,
    required this.candlesGeneration,
  });

  final String ticker;
  final Slice<StockOverview> overview;
  final Slice<List<Candle>> candles;

  /// `Period.week` initially (Requirement 12 AC 4).
  final Period period;

  /// Lives here rather than in widget state so it survives rebuilds caused
  /// by window size changes (Requirement 9 AC 22).
  final bool aboutExpanded;

  /// `false` until the first Favorites_Local_Store emission.
  final bool isFavorite;

  /// `false` until the first Favorites_Local_Store emission for this
  /// ticker; while pending, the favorite toggle renders the outlined star
  /// (Requirement 13 AC 10).
  final bool favoriteStateResolved;

  /// Set when a write to or a removal from the Favorites_Local_Store fails
  /// (Requirement 13 AC 11); `null` while no such failure is pending.
  final Failure? favoriteWriteFailure;

  /// Monotonic token incremented on every Candle request so a superseded
  /// response can be discarded (Requirement 10 AC 9, Requirement 12 AC 17).
  final int candlesGeneration;

  /// The initial state before the overview and Candle requests are issued.
  const StockDetailState.initial(this.ticker)
    : overview = const SliceLoading(),
      candles = const SliceLoading(),
      period = Period.week,
      aboutExpanded = false,
      isFavorite = false,
      favoriteStateResolved = false,
      favoriteWriteFailure = null,
      candlesGeneration = 0;

  StockDetailState copyWith({
    String? ticker,
    Slice<StockOverview>? overview,
    Slice<List<Candle>>? candles,
    Period? period,
    bool? aboutExpanded,
    bool? isFavorite,
    bool? favoriteStateResolved,
    Failure? favoriteWriteFailure,
    bool clearFavoriteWriteFailure = false,
    int? candlesGeneration,
  }) {
    return StockDetailState(
      ticker: ticker ?? this.ticker,
      overview: overview ?? this.overview,
      candles: candles ?? this.candles,
      period: period ?? this.period,
      aboutExpanded: aboutExpanded ?? this.aboutExpanded,
      isFavorite: isFavorite ?? this.isFavorite,
      favoriteStateResolved:
          favoriteStateResolved ?? this.favoriteStateResolved,
      favoriteWriteFailure: clearFavoriteWriteFailure
          ? null
          : (favoriteWriteFailure ?? this.favoriteWriteFailure),
      candlesGeneration: candlesGeneration ?? this.candlesGeneration,
    );
  }

  @override
  List<Object?> get props => [
    ticker,
    overview,
    candles,
    period,
    aboutExpanded,
    isFavorite,
    favoriteStateResolved,
    favoriteWriteFailure,
    candlesGeneration,
  ];
}
