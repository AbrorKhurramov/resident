import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class InsertTokenUseCase extends UseCase<void, InsertTokenUseCaseParams> {
  final AuthRepository authRepository;

  InsertTokenUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(InsertTokenUseCaseParams params) {
    return authRepository.insertToken(params.token);
  }
}

class InsertTokenUseCaseParams extends Equatable {
  final Token token;

  const InsertTokenUseCaseParams(this.token);

  @override
  List<Object?> get props => [token];
}
