import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:resident/feature/domain/entity/param/indication_history_param.dart';

class GetServiceResultUseCase extends UseCase<
    BasePaginationListResponse<ServiceResult>, GetServiceResultUseCaseParams> {
  final CounterRepository cardRepository;

  GetServiceResultUseCase(this.cardRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<ServiceResult>>> call(
      GetServiceResultUseCaseParams params) {
    return cardRepository.getServiceResultList(
      type: params.type,
      apartmentId: params.apartmentId,
      indicationHistoryParam: params.filterRequestParam,
      cancelToken: params.cancelToken,
    );
  }
}

class GetServiceResultUseCaseParams extends Equatable {
  final int type;
  final String apartmentId;
  final IndicationHistoryParam filterRequestParam;
  final CancelToken cancelToken;

  const GetServiceResultUseCaseParams({
    required this.type,
    required this.apartmentId,
    required this.filterRequestParam,
    required this.cancelToken,
  });

  @override
  List<Object?> get props => [
        type,
        filterRequestParam,
        cancelToken,
      ];
}
