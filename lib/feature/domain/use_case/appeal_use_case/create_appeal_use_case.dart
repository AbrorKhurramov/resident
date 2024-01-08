import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class CreateAppealUseCase extends UseCase<BaseResponse<AppealResponse>, CreateAppealUseCaseParams> {
  final AppealRepository appealRepository;

  CreateAppealUseCase(this.appealRepository);

  @override
  Future<Either<Failure, BaseResponse<AppealResponse>>> call(CreateAppealUseCaseParams params) {
    return appealRepository.createAppeal(appealRequest: params.appealRequest, cancelToken: params.cancelToken);
  }
}

class CreateAppealUseCaseParams extends Equatable {
  final AppealRequest appealRequest;
  final CancelToken cancelToken;

  const CreateAppealUseCaseParams(this.appealRequest, this.cancelToken);

  CreateAppealUseCaseParams copyWith({AppealRequest? appealRequest, CancelToken? cancelToken}) {
    return CreateAppealUseCaseParams(
      appealRequest ?? this.appealRequest,
      cancelToken ?? this.cancelToken,
    );
  }

  @override
  List<Object?> get props => [appealRequest, cancelToken];
}
