import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';


abstract class SupportRepository {
  Future<Either<Failure, BasePaginationListResponse<Support>>> getSupport({
    required String apartmentId,
    required FilterRequestParam filterRequestParam,
    required CancelToken cancelToken,
  });
}