import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

abstract class ServiceRepository {
  Future<Either<Failure, BasePaginationListResponse<MerchantResponse>>>
      getServicesList({
    required FilterRequestParam filterRequestParam,
    required CancelToken cancelToken,
  });


}
