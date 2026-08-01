// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'StocksViewer';

  @override
  String get retryButtonLabel => 'Retry';

  @override
  String get allStocksTitle => 'All stocks';

  @override
  String get searchStocksHint => 'Search stocks';

  @override
  String get marketDataHeading => 'Market Data';

  @override
  String get marketCapLabel => 'Market Cap';

  @override
  String get employeesLabel => 'Employees';

  @override
  String get listedDateLabel => 'Listed Date';

  @override
  String get sectorLabel => 'Sector';

  @override
  String get aboutHeading => 'About';

  @override
  String get showLessLabel => 'Show Less';

  @override
  String get readMoreLabel => 'Read More';

  @override
  String get cikLabel => 'CIK:';

  @override
  String get periodDay => 'Day';

  @override
  String get periodWeek => 'Week';

  @override
  String get periodMonth => 'Month';

  @override
  String get periodQuartal => 'Quartal';

  @override
  String get errorGenericHeadline => 'Oops! Something went wrong';

  @override
  String get noNetworkConnection => 'No network connection';

  @override
  String get serverProblemHasOccurred => 'Server problem has occurred';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get stocksNavigationLabel => 'Stocks';

  @override
  String get favoritesLoadingText => 'Loading favorites…';

  @override
  String get favoritesEmptyText =>
      'No favorites yet. Tap the star icon on a stock to add it here.';

  @override
  String get backButtonSemanticLabel => 'Return to previous screen';

  @override
  String get searchActionSemanticLabel => 'Search';

  @override
  String get closeSearchSemanticLabel => 'Close Search';

  @override
  String get logoSemanticLabel => 'Logo';

  @override
  String get noStocksMatchSearchText => 'No stocks match your search.';

  @override
  String get noStocksAvailableText => 'No stocks are available.';

  @override
  String get noChartDataText => 'No chart data is available.';

  @override
  String get addToFavoritesLabel => 'Add to favorites';

  @override
  String get removeFromFavoritesLabel => 'Remove from favorites';
}
