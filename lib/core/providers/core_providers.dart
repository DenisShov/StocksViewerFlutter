import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error/failure_mapper.dart';
import '../logging/app_logger.dart';
import '../network/dio_factory.dart';
import '../network/stocks_api_client.dart';

/// Shared core infrastructure providers read by more than one feature's
/// `<feature>_providers.dart` file.
///
/// `dio_factory.dart`'s own documentation states that `createDio()` builds
/// "the only `Dio` instance in the app", so exactly one `dioProvider` must
/// exist for every feature to read from. Declaring a separate `dioProvider`
/// in each feature's DI providers file (for example both
/// `stocks_list_providers.dart` and a later `stock_detail_providers.dart`)
/// would mean two files each declaring a provider of the same name,
/// violating the rule that every provider is declared in exactly one place
/// (Requirement 2 AC 11). The same reasoning applies to `AppLogger`,
/// `StocksApiClient`, and `FailureMapper`, which are likewise cross-feature
/// dependencies with no per-feature state.
///
/// This file lives under `lib/core/`, not under any `features/*/data/`
/// directory, so declaring providers here does not violate the data-layer
/// Riverpod denylist of Requirement 2 AC 2, which targets `features/*/data/`
/// only.
///
/// Every provider here is a plain, hand-written `Provider` constructor
/// (Requirement 2 AC 17).
final dioProvider = Provider<Dio>((ref) => createDio());

final appLoggerProvider = Provider<AppLogger>((ref) => const AppLogger());

final stocksApiClientProvider = Provider<StocksApiClient>(
  (ref) => StocksApiClient(ref.watch(dioProvider), ref.watch(appLoggerProvider)),
);

/// `FailureMapper` has no state and no dependencies, so it is shared
/// cheaply by every feature's repository implementation. No other
/// `failureMapperProvider` exists elsewhere in the codebase (Requirement 2
/// AC 11); a feature's `providers/` file should import and read this
/// provider rather than redeclaring it.
final failureMapperProvider = Provider<FailureMapper>((ref) => const FailureMapper());
