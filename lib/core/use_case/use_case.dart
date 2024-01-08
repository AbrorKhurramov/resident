import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:either_dart/either.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type?>> call(Params params);
}

class NoParams extends Equatable {
  final CancelToken? cancelToken;

  const NoParams({this.cancelToken});

  @override
  List<Object?> get props => [cancelToken];
}
