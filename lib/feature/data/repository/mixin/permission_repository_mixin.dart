import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/data/data_source/shared_preference_source/app_preference_source.dart';

mixin PermissionRepositoryMixin {
  late final AppPreferenceSource appSharedPreferenceSource;

  Future<Either<Failure, bool>> getPermission() async {
    try {
      return Right(await appSharedPreferenceSource.getPermission());
    } catch (e) {
      return Left(ExceptionFailure(object: e));
    }
  }

  Future<Either<Failure, void>> setPermission(bool params) async {
    try {
      return Right(await appSharedPreferenceSource.setPermission(params));
    } catch (e) {
      return Left(ExceptionFailure(object: e));
    }
  }
}
