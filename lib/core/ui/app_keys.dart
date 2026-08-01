import 'package:flutter/widgets.dart';

abstract final class AppKeys {
  static const Key stocksListScreen = Key('stocksListScreen');
  static const Key stockDetailScreen = Key('stockDetailScreen');
  static const Key favoritesScreen = Key('favoritesScreen');

  static const Key loadingPlaceholder = Key('loadingPlaceholder');

  static const Key errorView = Key('errorView');
  static const Key errorViewRetryButton = Key('errorViewRetryButton');
  static const Key errorViewIcon = Key('errorViewIcon');
  static const Key errorViewHeadline = Key('errorViewHeadline');
  static const Key errorViewMessage = Key('errorViewMessage');

  static const Key emptyStateMessage = Key('emptyStateMessage');

  static const Key stocksList = Key('stocksList');
  static const Key favoritesList = Key('favoritesList');

  static Key stockListCard(String ticker) => Key('stockListCard_$ticker');

  static const Key searchField = Key('searchField');
  static const Key searchActionButton = Key('searchActionButton');
  static const Key closeSearchButton = Key('closeSearchButton');

  static const Key favoriteToggle = Key('favoriteToggle');

  static const Key candleChart = Key('candleChart');
  static const Key candleChartMarker = Key('candleChartMarker');

  static const Key pagingRetryRow = Key('pagingRetryRow');
  static const Key pagingRetryRowMessage = Key('pagingRetryRowMessage');
  static const Key pagingRetryButton = Key('pagingRetryButton');

  static const Key periodSelector = Key('periodSelector');

  static Key periodButton(String period) => Key('periodButton_$period');

  static const Key refreshProgressIndicator = Key('refreshProgressIndicator');

  static const Key aboutToggle = Key('aboutToggle');
  static const Key backButton = Key('backButton');
}
