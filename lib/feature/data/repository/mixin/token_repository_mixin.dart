import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/data_source/database_source/app_database_source.dart';

import 'package:either_dart/either.dart';

mixin TokenRepositoryMixin {
  late final AppDatabaseSource appDatabaseSource;

  Future<Either<Failure, void>> insertToken(Token token) async {
    try {
      return Right(await appDatabaseSource.insertToken(token));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteToken() async {
    try {
      return Right(await appDatabaseSource.deleteToken());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Token?>> getToken() async {
    try {
      return Right(await appDatabaseSource.getToken());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
