import 'package:resident/app_package/domain/entity_package.dart';

class TokenExpireException implements Exception {
  TokenExpireException();
}

class ServerException implements Exception {
  final int? statusCode;
  final Message? message;

  ServerException({this.statusCode, this.message});
}

class ConnectionTimeOutException implements Exception {
  ConnectionTimeOutException();
}

class JsonCastException implements Exception {
  final String? message;

  JsonCastException({this.message});

  @override
  String toString() {
    return message.toString();
  }
}
class CancelException implements Exception{
  const CancelException();
}

class NetworkException implements Exception {
  const NetworkException();
}
