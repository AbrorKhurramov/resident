import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';

mixin DocumentRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, BasePaginationListResponse<Document>>> getDocuments(
      {required FilterRequestParam filterRequestParam,
      required CancelToken cancelToken}) async {
    Either<Exception, BasePaginationListResponse<Document>> response =
        await appRemoteSource.getDocuments(
      filterRequestParam: filterRequestParam,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BasePaginationListResponse<Document>>(response);
  }

  Future<Either<Failure, BaseResponse<Document>>> getDocumentById({
    required String documentId,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<Document>> response = await appRemoteSource
        .getDocumentById(documentId: documentId, cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<Document>>(response);
  }
}
