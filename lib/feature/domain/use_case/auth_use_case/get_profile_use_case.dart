import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class GetProfileUseCase extends UseCase<User, NoParams> {
  final AuthRepository authRepository;

  GetProfileUseCase(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return authRepository.getProfile(cancelToken: params.cancelToken!);
  }
}
