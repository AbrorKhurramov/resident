import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class ChangePasswordUseCase extends UseCase<BaseResponse<void>, ChangePasswordUseCaseParams> {
  final AuthRepository authRepository;

  ChangePasswordUseCase(this.authRepository);

  @override
  Future<Either<Failure, BaseResponse<void>>> call(ChangePasswordUseCaseParams params) {
    return authRepository.changePassword(
      changePasswordRequest: params.changePasswordRequest,
      cancelToken: params.cancelToken,
    );
  }
}

class ChangePasswordUseCaseParams extends Equatable {
  final ChangePasswordRequest changePasswordRequest;
  final CancelToken cancelToken;

  const ChangePasswordUseCaseParams(this.changePasswordRequest, this.cancelToken);

  @override
  List<Object?> get props => [changePasswordRequest, cancelToken];
}
