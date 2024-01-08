import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/data_source/database_source/app_database_source.dart';

import 'package:either_dart/either.dart';

mixin UserRepositoryMixin {
  late final AppDatabaseSource appDatabaseSource;

  Future<Either<Failure, void>> insertUser(User user) async {
    try {
      return Right(await appDatabaseSource.insertUser(user));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteUser() async {
    try {
      return Right(await appDatabaseSource.deleteUser());
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
