import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class AppealHistoryByIDUseCase extends UseCase<
    BaseResponse<AppealResponse>, AppealHistoryByIDUseCaseParams> {
  final AppealRepository appealRepository;

  AppealHistoryByIDUseCase(this.appealRepository);

  @override
  Future<Either<Failure, BaseResponse<AppealResponse>>> call(
      AppealHistoryByIDUseCaseParams params) {
    return appealRepository.getHistoryAppealsById(
      appealId: params.appealId,
        cancelToken: params.cancelToken);
  }
}

class AppealHistoryByIDUseCaseParams extends Equatable {
  final String appealId;
  final CancelToken cancelToken;

  const AppealHistoryByIDUseCaseParams(
      this.appealId, this.cancelToken);

  @override
  List<Object?> get props => [appealId,cancelToken];
}
