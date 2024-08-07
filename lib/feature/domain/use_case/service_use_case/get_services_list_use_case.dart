import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class GetServicesListUseCase extends UseCase<
    BasePaginationListResponse<MerchantResponse>, GetServicesListUseCaseParams> {

  final ServiceRepository serviceRepository;

  GetServicesListUseCase(this.serviceRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<MerchantResponse>>> call(GetServicesListUseCaseParams params) {
    return serviceRepository.getServicesList(filterRequestParam: params.filterRequestParam, cancelToken: params.cancelToken);
  }
}

class GetServicesListUseCaseParams extends Equatable {
  final FilterRequestParam filterRequestParam;
  final CancelToken cancelToken;

  const GetServicesListUseCaseParams(this.filterRequestParam, this.cancelToken);

  @override
  List<Object?> get props => [filterRequestParam,cancelToken];


}



