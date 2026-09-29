# StocksViewer Flutter

StocksViewer is a Flutter port of the native Android StocksViewer application. It displays a searchable and paginated stock list, company details, candlestick charts, and locally persisted favorites.

The project uses a feature-first Clean Architecture inspired by the [Flutter Riverpod Clean Architecture template](https://ssoad.github.io/flutter_riverpod_clean_architecture/). Riverpod provides dependency injection and presentation state management without introducing framework dependencies into the domain layer.

## Features

- Paginated stock and ETF list
- Debounced stock search
- Pull-to-refresh and pagination retry
- Company overview and market information
- Day, week, month, and quarter candlestick periods
- Reactive local favorites
- Light and dark system themes
- English localization
- Android and iOS support

## Architecture

The application is organized by feature. Each feature contains its own domain, data, presentation, and dependency-composition code.

The dependency rules are:

- `domain` contains pure business entities, repository contracts, services, and use cases. It does not depend on Flutter, Riverpod, data implementations, or presentation.
- `data` contains DTOs, mappers, data sources, and repository implementations. It depends on domain contracts but not presentation.
- `presentation` contains screens, widgets, immutable state, and Riverpod notifiers. It accesses data through domain use cases.
- `providers` is the composition root for a feature. It constructs data sources, repository implementations, and use cases.
- `core` contains shared infrastructure and UI used by multiple features.

Architecture tests under `test/architecture` enforce these dependency boundaries.

## Project structure

```text
lib/
├── core/
│   ├── constants/       Build-time configuration and API constants
│   ├── error/           Failure types, mapping, and localized resolution
│   ├── logging/         Redacted application logging
│   ├── network/         Dio setup, API client, authentication, URL helpers
│   ├── providers/       Shared infrastructure providers
│   ├── router/          GoRouter configuration and navigation shell
│   ├── storage/         Drift database and tables
│   ├── theme/           Material themes and chart colors
│   ├── ui/              Shared design-system widgets
│   └── utils/           Formatting and clock helpers
├── features/
│   ├── stocks_list/
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── providers/
│   ├── stock_detail/
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── providers/
│   └── favorites/
│       ├── data/
│       ├── domain/
│       ├── presentation/
│       └── providers/
├── l10n/                ARB input and generated localizations
└── main.dart            ProviderScope and application bootstrap
```

## Feature responsibilities

### Stocks list

The stocks-list feature retrieves ticker pages from the remote API. Its notifier manages first-page loading, debounced search, forward pagination, pull-to-refresh, append failures, retry, and stale-response protection.

### Stock detail

The stock-detail feature loads company overview and candle data independently so one request can succeed when the other fails. The ticker-scoped provider is auto-disposed when its route leaves. Chart-period selection and favorite state are retained in immutable presentation state.

### Favorites

The favorites feature persists only favorite stocks in SQLite through Drift. Database queries expose reactive streams, allowing the favorites screen and detail-screen star to update without manual reloads. Favorite writes are serialized by a domain use case to prevent rapid add/remove races.

## State management and dependency injection

The application uses hand-written Riverpod providers:

- `Provider` constructs infrastructure, repositories, and use cases.
- `NotifierProvider` owns stocks-list and favorites presentation state.
- `NotifierProvider.autoDispose.family` creates ticker-specific stock-detail state.
- `ProviderScope` in `main.dart` owns the application dependency container.

Presentation states use sealed classes for mutually exclusive loading, content, empty, and error phases. `Equatable` supplies value equality for entities and state objects.

## Data and error flow

Remote requests follow this path:

```text
Screen → Notifier → Use case → Repository interface
       → Repository implementation → Remote data source → API client → Dio
```

The data layer maps API DTOs into domain entities. Repository implementations convert thrown exceptions into the sealed `Failure` hierarchy. Use cases return `Either<Failure, Value>` from `fpdart`, requiring callers to handle success and failure explicitly.

Local favorite requests follow the same domain boundary but end at a Drift-backed local store instead of the network.

## Navigation

`go_router` provides a stateful two-branch navigation shell:

- `/stocks`
- `/stocks/detail/:ticker`
- `/favorites`
- `/favorites/detail/:ticker`

Each bottom-navigation destination preserves its own navigation stack. The bottom navigation bar is hidden on detail routes.

## Libraries

### Runtime dependencies

| Library | Usage |
| --- | --- |
| `flutter_riverpod` | Dependency injection and notifier-based presentation state |
| `go_router` | Declarative routing, nested detail routes, and stateful navigation branches |
| `dio` | Polygon/Massive HTTP requests, timeouts, and API-key interception |
| `fpdart` | `Either<Failure, Value>` results across repository boundaries |
| `equatable` | Value equality for domain entities and immutable presentation state |
| `drift` | Typed SQLite schema, queries, writes, and reactive favorite streams |
| `drift_flutter` | Platform-aware Drift database connection |
| `sqlite3_flutter_libs` | SQLite native libraries for Flutter platforms |
| `json_annotation` | DTO serialization annotations |
| `intl` | Date, employee-count, and numeric display formatting |
| `cached_network_image` | Cached company branding images |
| `syncfusion_flutter_charts` | Candlestick chart rendering and chart interaction |
| `url_launcher` | Opening company websites outside the application |
| `flutter_localizations` | Flutter localization delegates and localized Material widgets |

`shimmer` is currently declared in `pubspec.yaml`, but the application uses its own opacity-based `ShimmerBlock` implementation and does not import the package.

### Development dependencies

| Library | Usage |
| --- | --- |
| `flutter_test` | Unit, provider, architecture, and widget tests |
| `flutter_lints` | Standard Flutter analyzer rules |
| `riverpod_lint` and `custom_lint` | Riverpod-specific static checks |
| `build_runner` | Executes Drift and JSON serialization generators |
| `drift_dev` | Generates typed Drift database code |
| `json_serializable` | Generates DTO `fromJson` and `toJson` code |

`mocktail` and `glados` are declared development dependencies but are not currently imported by the test suite. Current tests use small hand-written fakes and controllable repositories.

## API configuration

The app requires a Polygon/Massive API key. API keys must not be committed to version control.

Create `dart_defines/local.json`:

```json
{
  "POLYGON_API_KEY_FILE": "your_api_key"
}
```

The file is ignored by Git. Run the application with:

```sh
flutter run --dart-define-from-file=dart_defines/local.json
```

A direct define is also supported and takes precedence over the file value:

```sh
flutter run --dart-define=POLYGON_API_KEY=your_api_key
```

## Running from VS Code

Open the `stocks_viewer_flutter` directory as the VS Code workspace. The included `.vscode/launch.json` starts `lib/main.dart` and automatically supplies `dart_defines/local.json`.

Select **StocksViewer Flutter**, then use either:

- **Run > Start Debugging**
- **Run > Run Without Debugging**

## Code generation

Run code generation after changing Drift tables or JSON DTO annotations:

```sh
dart run build_runner build --delete-conflicting-outputs
```

Flutter generates localization classes from `lib/l10n/arb/app_en.arb` using `l10n.yaml`.

## Verification

```sh
flutter analyze
flutter test
```

The test suite includes:

- Architecture dependency tests
- Core utility and networking tests
- Domain use-case and service tests
- Riverpod notifier feature tests
- Chart and shared-widget tests

