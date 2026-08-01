import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure();
}

class ServerFailure extends Failure {
  const ServerFailure({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  @override
  List<Object?> get props => [statusCode, message];
}

class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  List<Object?> get props => const [];
}

class GeneralFailure extends Failure {
  const GeneralFailure();

  @override
  List<Object?> get props => const [];
}
