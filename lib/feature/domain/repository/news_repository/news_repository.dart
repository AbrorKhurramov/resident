import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

abstract class NewsRepository {
  Future<Either<Failure, BasePaginationListResponse<Newness>>> getNews({
    required int page,
    int? size,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<Newness>>> getNewById({
    required int newId,
    required CancelToken cancelToken,
  });
}
