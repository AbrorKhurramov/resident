import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/use_case.dart';
import '../../repository/auth_repository/auth_repository.dart';

class ForceUpdateUseCase extends UseCase<bool, ForceUpdateUseCaseParams> {
  final AuthRepository authRepository;

  ForceUpdateUseCase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(ForceUpdateUseCaseParams params) {
    return authRepository.forceUpdate(version: params.version,type: params.type, cancelToken: params.cancelToken);
  }
}

class ForceUpdateUseCaseParams extends Equatable {
  final String version;
  final String type;
  final CancelToken cancelToken;

  const ForceUpdateUseCaseParams(this.version,this.type, this.cancelToken);

  @override
  List<Object?> get props => [version,type,cancelToken];
}
