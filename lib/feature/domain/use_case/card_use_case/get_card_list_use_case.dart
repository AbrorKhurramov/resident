import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class GetCardListUseCase extends UseCase<BasePaginationListResponse<CardResponse>, GetCardListUseCaseParams> {
  final CardRepository cardRepository;

  GetCardListUseCase(this.cardRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<CardResponse>>> call(GetCardListUseCaseParams params) async {
    return cardRepository.getCardList(
      filterRequestParam: params.filterRequestParam,
      cancelToken: params.cancelToken,
    );
  }
}

class GetCardListUseCaseParams extends Equatable {
  final FilterRequestParam filterRequestParam;
  final CancelToken cancelToken;

  const GetCardListUseCaseParams({
    required this.filterRequestParam,
    required this.cancelToken,
  });

  @override
  List<Object?> get props => [
        filterRequestParam,
        cancelToken,
      ];
}
