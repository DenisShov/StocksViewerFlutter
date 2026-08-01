import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/candle.dart';
import '../../domain/entities/period.dart';
import '../../domain/entities/stock_overview.dart';

sealed class Slice<T> extends Equatable {
  const Slice();
}

class SliceLoading<T> extends Slice<T> {
  const SliceLoading();

  @override
  List<Object?> get props => const [];
}

class SliceData<T> extends Slice<T> {
  const SliceData(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}

class SliceError<T> extends Slice<T> {
  const SliceError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

class StockDetailState extends Equatable {
  const StockDetailState({
    required this.ticker,
    required this.overview,
    required this.brandingImageUrl,
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
  final String? brandingImageUrl;
  final Slice<List<Candle>> candles;

  final Period period;

  final bool aboutExpanded;

  final bool isFavorite;

  final bool favoriteStateResolved;

  final Failure? favoriteWriteFailure;

  final int candlesGeneration;

  const StockDetailState.initial(this.ticker)
    : overview = const SliceLoading(),
      brandingImageUrl = null,
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
    String? brandingImageUrl,
    bool clearBrandingImageUrl = false,
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
      brandingImageUrl: clearBrandingImageUrl
          ? null
          : (brandingImageUrl ?? this.brandingImageUrl),
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
    brandingImageUrl,
    candles,
    period,
    aboutExpanded,
    isFavorite,
    favoriteStateResolved,
    favoriteWriteFailure,
    candlesGeneration,
  ];
}
