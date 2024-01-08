import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class InsertUserUseCase extends UseCase<void, InsertUserUseCaseParams> {
  final AuthRepository authRepository;

  InsertUserUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(InsertUserUseCaseParams params) {
    return authRepository.insertUser(params.user);
  }
}

class InsertUserUseCaseParams extends Equatable {
  final User user;

  const InsertUserUseCaseParams(this.user);

  @override
  List<Object?> get props => [user];
}
