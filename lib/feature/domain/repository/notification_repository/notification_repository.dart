import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';

abstract class NotificationRepository {
  Future<Either<Failure, void>> setNotification(bool params);

  Future<Either<Failure, bool>> getNotification();


}
