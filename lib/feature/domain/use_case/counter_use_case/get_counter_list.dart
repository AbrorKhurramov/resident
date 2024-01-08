import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class GetCounterListUseCase extends UseCase<BasePaginationListResponse<Counter>,
    GetCounterListUseCaseParams> {
  final CounterRepository cardRepository;

  GetCounterListUseCase(this.cardRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<Counter>>> call(
      GetCounterListUseCaseParams params) {
    return cardRepository.getCounterList(
      type: params.type,
      apartmentId: params.apartmentId,
      cancelToken: params.cancelToken,
    );
  }
}

class GetCounterListUseCaseParams extends Equatable {
  final int type;
  final String apartmentId;
  final CancelToken cancelToken;

  const GetCounterListUseCaseParams({
    required this.type,
    required this.apartmentId,
    required this.cancelToken,
  });

  @override
  List<Object?> get props => [
        type,
        apartmentId,
        cancelToken,
      ];
}
