import '../../l10n/generated/app_localizations.dart';
import 'failure.dart';

/// The presentation-layer component converting a [Failure] into a
/// user-facing message.
///
/// This class takes the generated [AppLocalizations] object through its
/// constructor, so it never needs a `BuildContext` and never drags Flutter
/// into the data layer. It lives in `lib/core/error/`, in the same
/// directory as `failure.dart`, but in its own file; the data layer only
/// ever imports `failure.dart`, never this file.
class FailureMessageResolver {
  const FailureMessageResolver(this._l10n);

  final AppLocalizations _l10n;

  String resolve(Failure failure) => switch (failure) {
    ServerFailure(:final message) when message.trim().isNotEmpty => message,
    ServerFailure() => _l10n.serverProblemHasOccurred,
    NetworkFailure() => _l10n.noNetworkConnection,
    GeneralFailure() => _l10n.somethingWentWrong,
  };
}
