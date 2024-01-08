import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class DeleteTokenUseCase extends UseCase<void, NoParams> {
  final AuthRepository authRepository;

  DeleteTokenUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return authRepository.deleteToken();
  }
}
