import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

abstract class DocumentRepository {
  Future<Either<Failure, BasePaginationListResponse<Document>>> getDocuments({
    required FilterRequestParam filterRequestParam,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<Document>>> getDocumentById({
    required String documentId,
    required CancelToken cancelToken,
  });
}
