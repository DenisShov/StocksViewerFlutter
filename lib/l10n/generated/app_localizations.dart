import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application display name, shown as the app bar title on the Stocks_List_Screen.
  ///
  /// In en, this message translates to:
  /// **'StocksViewer'**
  String get appTitle;

  /// Label of the retry button rendered inside the Error_View and inside the list retry row.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButtonLabel;

  /// Stocks_List_Screen app bar title while search is inactive.
  ///
  /// In en, this message translates to:
  /// **'All stocks'**
  String get allStocksTitle;

  /// Hint text of the search text field while it is empty.
  ///
  /// In en, this message translates to:
  /// **'Search stocks'**
  String get searchStocksHint;

  /// Heading of the market data section on the Stock_Detail_Screen.
  ///
  /// In en, this message translates to:
  /// **'Market Data'**
  String get marketDataHeading;

  /// Label of the market capitalization card on the Stock_Detail_Screen.
  ///
  /// In en, this message translates to:
  /// **'Market Cap'**
  String get marketCapLabel;

  /// Label of the employee count card on the Stock_Detail_Screen.
  ///
  /// In en, this message translates to:
  /// **'Employees'**
  String get employeesLabel;

  /// Label of the listed date row on the Stock_Detail_Screen.
  ///
  /// In en, this message translates to:
  /// **'Listed Date'**
  String get listedDateLabel;

  /// Label of the sector card on the Stock_Detail_Screen.
  ///
  /// In en, this message translates to:
  /// **'Sector'**
  String get sectorLabel;

  /// Heading of the about section on the Stock_Detail_Screen.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutHeading;

  /// Toggle label of the about section while it is expanded.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get showLessLabel;

  /// Toggle label of the about section while it is collapsed.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMoreLabel;

  /// Label prefix of the CIK row on the Stock_Detail_Screen.
  ///
  /// In en, this message translates to:
  /// **'CIK:'**
  String get cikLabel;

  /// Period_Selector button label for the day period.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get periodDay;

  /// Period_Selector button label for the week period.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get periodWeek;

  /// Period_Selector button label for the month period.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get periodMonth;

  /// Period_Selector button label for the quartal period.
  ///
  /// In en, this message translates to:
  /// **'Quartal'**
  String get periodQuartal;

  /// Headline of the Error_View, and the fallback text of the list retry row when its resolved message is blank.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong'**
  String get errorGenericHeadline;

  /// Failure_Message_Resolver text for a NetworkFailure.
  ///
  /// In en, this message translates to:
  /// **'No network connection'**
  String get noNetworkConnection;

  /// Failure_Message_Resolver text for a ServerFailure whose message is blank.
  ///
  /// In en, this message translates to:
  /// **'Server problem has occurred'**
  String get serverProblemHasOccurred;

  /// Failure_Message_Resolver text for a GeneralFailure.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// Favorites screen app bar title, rendered in every favorites state.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// Label of the stocks destination in the bottom navigation bar.
  ///
  /// In en, this message translates to:
  /// **'Stocks'**
  String get stocksNavigationLabel;

  /// Centered text rendered while the favorites stream has not yet emitted.
  ///
  /// In en, this message translates to:
  /// **'Loading favorites…'**
  String get favoritesLoadingText;

  /// Centered text rendered when the favorites store holds no records.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet. Tap the star icon on a stock to add it here.'**
  String get favoritesEmptyText;

  /// Semantic label of the Stock_Detail_Screen app bar back control.
  ///
  /// In en, this message translates to:
  /// **'Return to previous screen'**
  String get backButtonSemanticLabel;

  /// Semantic label of the search action control while search is inactive.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchActionSemanticLabel;

  /// Semantic label of the close-search control while search is active.
  ///
  /// In en, this message translates to:
  /// **'Close Search'**
  String get closeSearchSemanticLabel;

  /// Semantic label of the company icon image on the Stock_Detail_Screen, in every loading, error, and loaded state.
  ///
  /// In en, this message translates to:
  /// **'Logo'**
  String get logoSemanticLabel;

  /// Empty-state message rendered when the first page of a non-empty search query succeeds with zero items.
  ///
  /// In en, this message translates to:
  /// **'No stocks match your search.'**
  String get noStocksMatchSearchText;

  /// Empty-state message rendered when the first page of the full ticker list succeeds with zero items.
  ///
  /// In en, this message translates to:
  /// **'No stocks are available.'**
  String get noStocksAvailableText;

  /// Empty-state message rendered when the selected period has no candle records.
  ///
  /// In en, this message translates to:
  /// **'No chart data is available.'**
  String get noChartDataText;

  /// Semantic label of the favorite toggle while the displayed ticker is absent from the Favorites_Local_Store.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get addToFavoritesLabel;

  /// Semantic label of the favorite toggle while the displayed ticker is stored in the Favorites_Local_Store.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFromFavoritesLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
