import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';


class GetPermissionUseCase extends UseCase<void, NoParams> {
  final ByBiometricsPermissionRepository _byBiometricsPermissionRepository;

  GetPermissionUseCase(this._byBiometricsPermissionRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return _byBiometricsPermissionRepository.getPermission();
  }
}
