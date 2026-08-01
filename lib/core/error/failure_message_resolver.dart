import '../../l10n/generated/app_localizations.dart';
import 'failure.dart';

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
