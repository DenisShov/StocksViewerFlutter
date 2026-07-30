import 'package:flutter/widgets.dart';

/// Widget keys used across the app, mirroring the Android_Original's test
/// tags (Requirement 22 AC 12).
///
/// All keys are `const` and, for the parameterized factories, derived only
/// from their input, so key values stay unchanged across rebuilds and state
/// transitions.
abstract final class AppKeys {
  // Screen roots.
  static const Key stocksListScreen = Key('stocksListScreen');
  static const Key stockDetailScreen = Key('stockDetailScreen');
  static const Key favoritesScreen = Key('favoritesScreen');

  /// First-page skeleton container, detail skeleton, chart Shimmer_Block.
  static const Key loadingPlaceholder = Key('loadingPlaceholder');

  // Error_View parts.
  static const Key errorView = Key('errorView');
  static const Key errorViewRetryButton = Key('errorViewRetryButton');
  static const Key errorViewIcon = Key('errorViewIcon');
  static const Key errorViewHeadline = Key('errorViewHeadline');
  static const Key errorViewMessage = Key('errorViewMessage');

  /// Empty-state text on all three screens.
  static const Key emptyStateMessage = Key('emptyStateMessage');

  // The scrollable lists.
  static const Key stocksList = Key('stocksList');
  static const Key favoritesList = Key('favoritesList');

  /// Key for each Stock_List_Card, derived only from [ticker].
  static Key stockListCard(String ticker) => Key('stockListCard_$ticker');

  // Search_App_Bar controls.
  static const Key searchField = Key('searchField');
  static const Key searchActionButton = Key('searchActionButton');
  static const Key closeSearchButton = Key('closeSearchButton');

  /// Detail app bar trailing action.
  static const Key favoriteToggle = Key('favoriteToggle');

  // Chart and its marker.
  static const Key candleChart = Key('candleChart');
  static const Key candleChartMarker = Key('candleChartMarker');

  // The Requirement 6 AC 10 retry row.
  static const Key pagingRetryRow = Key('pagingRetryRow');
  static const Key pagingRetryRowMessage = Key('pagingRetryRowMessage');
  static const Key pagingRetryButton = Key('pagingRetryButton');

  /// Period_Selector root.
  static const Key periodSelector = Key('periodSelector');

  /// Key for each Period_Selector button, derived only from [period] (the
  /// Period enum's name, e.g. `day`/`week`/`month`/`quartal`, not the
  /// localized label), so the key is stable regardless of locale.
  static Key periodButton(String period) => Key('periodButton_$period');

  /// The pull-to-refresh linear indicator.
  static const Key refreshProgressIndicator = Key('refreshProgressIndicator');

  // Detail about toggle, app bar back control.
  static const Key aboutToggle = Key('aboutToggle');
  static const Key backButton = Key('backButton');
}
