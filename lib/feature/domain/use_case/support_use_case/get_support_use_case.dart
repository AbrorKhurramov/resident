

import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
class GetSupportUseCase extends UseCase<BasePaginationListResponse<Support>,GetSupportUseCaseParams>{
  final SupportRepository supportRepository;

  GetSupportUseCase(this.supportRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<Support>?>> call(GetSupportUseCaseParams params) {
    return supportRepository.getSupport(apartmentId: params.apartmentId, filterRequestParam: params.filterRequestParam, cancelToken: params.cancelToken);
  }


}









class GetSupportUseCaseParams extends Equatable {
  final String apartmentId;
  final CancelToken cancelToken;
  final FilterRequestParam filterRequestParam;

  const GetSupportUseCaseParams({
    required this.apartmentId,
    required this.filterRequestParam,
    required this.cancelToken,
  });

  @override
  List<Object?> get props => [
    apartmentId,
    filterRequestParam,
    cancelToken,
  ];
}
