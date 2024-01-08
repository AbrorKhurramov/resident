import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:resident/feature/domain/entity/param/appeal_history_param.dart';

class AppealHistoryUseCase extends UseCase<
    BasePaginationListResponse<AppealResponse>, AppealHistoryUseCaseParams> {
  final AppealRepository appealRepository;

  AppealHistoryUseCase(this.appealRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<AppealResponse>>> call(
      AppealHistoryUseCaseParams params) {
    return appealRepository.getHistoryAppeals(
        apartmentId: params.apartmentId,
        filterRequestParam: params.filterRequestParam,
        cancelToken: params.cancelToken);
  }
}

class AppealHistoryUseCaseParams extends Equatable {
  final String apartmentId;
  final AppealHistoryParam filterRequestParam;
  final CancelToken cancelToken;

  const AppealHistoryUseCaseParams(
      this.apartmentId, this.filterRequestParam, this.cancelToken);

  @override
  List<Object?> get props => [apartmentId, filterRequestParam, cancelToken];
}
