import 'package:equatable/equatable.dart';

/// The sealed domain error type returned in the left channel of
/// `Either<Failure, T>`.
///
/// This file is pure Dart: it has no Flutter and no `intl` import so that
/// both the `data/` and `domain/` layers of every feature may depend on it.
sealed class Failure extends Equatable {
  const Failure();
}

/// A failure produced by a non-2xx HTTP response or by a 2xx response with
/// an absent, null, or empty body.
class ServerFailure extends Failure {
  const ServerFailure({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  @override
  List<Object?> get props => [statusCode, message];
}

/// A failure produced by a transport-level connectivity problem, such as a
/// failed host lookup, a refused connection, or an elapsed timeout.
class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  List<Object?> get props => const [];
}

/// A failure produced by any condition that is neither a `ServerFailure`
/// nor a `NetworkFailure`.
class GeneralFailure extends Failure {
  const GeneralFailure();

  @override
  List<Object?> get props => const [];
}
