import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class UpdateProfileUseCase extends UseCase<BaseResponse<void>, UpdateProfileUseCaseParams> {
  final AuthRepository authRepository;

  UpdateProfileUseCase(this.authRepository);

  @override
  Future<Either<Failure, BaseResponse<void>>> call(UpdateProfileUseCaseParams params) {
    return authRepository.updateProfile(
      userUpdateRequest: params.userUpdateRequest,
      cancelToken: params.cancelToken,
    );
  }
}

class UpdateProfileUseCaseParams extends Equatable {
  final UserUpdateRequest userUpdateRequest;
  final CancelToken cancelToken;

  const UpdateProfileUseCaseParams(this.userUpdateRequest, this.cancelToken);

  @override
  List<Object?> get props => [userUpdateRequest, cancelToken];
}
