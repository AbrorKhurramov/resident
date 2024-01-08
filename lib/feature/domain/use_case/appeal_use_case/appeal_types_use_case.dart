import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class AppealTypesUseCase extends UseCase<BasePaginationListResponse<AppealType>,
    AppealTypesUseCaseParams> {
  final AppealRepository appealRepository;

  AppealTypesUseCase(this.appealRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<AppealType>>> call(
      AppealTypesUseCaseParams params) {
    return appealRepository.getAppealTypes(
      apartmentId: params.apartmentId,
      page: params.page,
      cancelToken: params.cancelToken,
    );
  }
}

class AppealTypesUseCaseParams extends Equatable {
  final String apartmentId;
  final int page;
  final CancelToken cancelToken;

  const AppealTypesUseCaseParams(this.apartmentId, this.page, this.cancelToken);

  @override
  List<Object?> get props => [apartmentId, page, cancelToken];
}
