import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';

class SetPermissionUseCase extends UseCase<void, SetPermissionParams> {
  final ByBiometricsPermissionRepository _byBiometricsPermissionRepository;

  SetPermissionUseCase(this._byBiometricsPermissionRepository);

  @override
  Future<Either<Failure, void>> call(SetPermissionParams params) {
    return _byBiometricsPermissionRepository.setPermission(params.permission);
  }
}

class SetPermissionParams extends Equatable {
  final bool permission;

  const SetPermissionParams(this.permission);

  @override
  List<Object?> get props => [permission];
}
