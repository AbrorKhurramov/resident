import 'package:equatable/equatable.dart';
import 'package:resident/app_package/domain/entity_package.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class TokenExpiryFailure extends Failure {}

class ServerFailure extends Failure {
  final int? statusCode;
  final Message? message;

  ServerFailure({this.statusCode, this.message});

  @override
  String toString() {
    return message.toString();
  }

  @override
  List<Object?> get props => [statusCode, message];
}

class ConnectionTimeOutFailure extends Failure {}

class JsonCastFailure extends Failure {
  final String? message;

  JsonCastFailure({this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return 'JsonCastFailure{message: $message}';
  }
}

class NetworkFailure extends Failure {}

class CancelFailure extends Failure{}


class DatabaseFailure extends Failure {
  final String message;

  DatabaseFailure({required this.message});

  @override
  String toString() {
    return 'DatabaseFailure{message: $message}';
  }

  @override
  List<Object?> get props => [message];
}

class ExceptionFailure extends Failure {
  final Object object;

  ExceptionFailure({required this.object});

  @override
  List<Object?> get props => [object];

  @override
  String toString() {
    return 'ExceptionFailure{object: $object}';
  }
}
