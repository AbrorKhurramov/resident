import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';

import 'package:either_dart/either.dart';

class DeleteUserUseCase extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  DeleteUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return authRepository.deleteUser();
  }
}
