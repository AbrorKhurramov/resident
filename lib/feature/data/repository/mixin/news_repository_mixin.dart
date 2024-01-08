import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';

mixin NewsRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, BasePaginationListResponse<Newness>>> getNews(
      {required int page, int? size, required CancelToken cancelToken}) async {
    Either<Exception, BasePaginationListResponse<Newness>> response =
        await appRemoteSource.getNews(
            page: page, size: size, cancelToken: cancelToken);

    return getEitherResponse<BasePaginationListResponse<Newness>>(response);
  }

  Future<Either<Failure, BaseResponse<Newness>>> getNewById(
      {required int newId, required CancelToken cancelToken}) async {
    Either<Exception, BaseResponse<Newness>> response = await appRemoteSource
        .getNewById(newId: newId, cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<Newness>>(response);
  }
}
