import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/data/data_source/shared_preference_source/app_preference_source.dart';

mixin NotificationRepositoryMixin {
  late final AppPreferenceSource appSharedPreferenceSource;

  Future<Either<Failure, bool>> getNotification() async {
    try {
      return Right(await appSharedPreferenceSource.getNotification());
    } catch (e) {
      return Left(ExceptionFailure(object: e));
    }
  }

  Future<Either<Failure, void>> setNotification(bool params) async {
    try {
      return Right(await appSharedPreferenceSource.setNotification(params));
    } catch (e) {
      return Left(ExceptionFailure(object: e));
    }
  }
}
