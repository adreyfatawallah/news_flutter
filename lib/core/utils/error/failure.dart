import 'package:equatable/equatable.dart';

abstract class Failure with Equatable {
  final String error;

  const Failure(this.error);

  @override
  List<Object?> get props => [error];
}

class ServerFailure extends Failure {
  const ServerFailure(super.error);

  @override
  String toString() {
    return "ServerFailure: $error";
  }
}

class LocalFailure extends Failure {
  const LocalFailure(super.error);

  @override
  String toString() {
    return "LocalFailure: $error";
  }
}
