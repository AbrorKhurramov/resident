import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';
import 'package:resident/feature/domain/entity/response/support.dart';

mixin SupportRepositoryMixin implements AppRepositoryMixin{
  late final AppRemoteSource appRemoteSource;
  Future<Either<Failure, BasePaginationListResponse<Support>>> getSupport(
      {
        required String apartmentId,
        required FilterRequestParam filterRequestParam,
        required CancelToken cancelToken}) async {
    Either<Exception, BasePaginationListResponse<Support>> response =
    await appRemoteSource.getSupport(
      apartmentId: apartmentId,
      filterRequestParam: filterRequestParam,
      cancelToken: cancelToken,
    );
    print("SupportRepositoryMixin");
   response.fold((left) => print("left"), (right) => print(right.data.toString()));
    return getEitherResponse<BasePaginationListResponse<Support>>(response);
  }
}