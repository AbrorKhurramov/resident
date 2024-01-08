import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';

abstract class ByBiometricsPermissionRepository {
  Future<Either<Failure, void>> setPermission(bool params);

  Future<Either<Failure, bool>> getPermission();
}
