import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class GetDocumentsUseCase extends UseCase<BasePaginationListResponse<Document>,
    GetDocumentsUseCaseParams> {
  final DocumentRepository documentRepository;

  GetDocumentsUseCase(this.documentRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<Document>>> call(
      GetDocumentsUseCaseParams params) {
    return documentRepository.getDocuments(
        filterRequestParam: params.filterRequestParam,
        cancelToken: params.cancelToken);
  }
}

class GetDocumentsUseCaseParams extends Equatable {
  final String apartmentId;
  final FilterRequestParam filterRequestParam;
  final CancelToken cancelToken;

  const GetDocumentsUseCaseParams(
      this.apartmentId, this.filterRequestParam, this.cancelToken);

  @override
  List<Object?> get props => [apartmentId, filterRequestParam, cancelToken];
}
