import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/data/data_source/shared_preference_source/app_preference_source.dart';

mixin PinCodeRepositoryMixin {
  late final AppPreferenceSource appSharedPreferenceSource;

  Future<Either<Failure, String?>> getPinCode() async {
    try {
      return Right(await appSharedPreferenceSource.getPinCode());
    } catch (e) {
      return Left(ExceptionFailure(object: e));
    }
  }

  Future<Either<Failure, void>> setPinCode(String pinCode) async {
    try {
      return Right(await appSharedPreferenceSource.setPinCode(pinCode));
    } catch (e) {
      return Left(ExceptionFailure(object: e));
    }
  }

  Future<Either<Failure, void>> removePinCode() async {
    try {
      return Right(await appSharedPreferenceSource.removePinCode());
    } catch (e) {
      return Left(ExceptionFailure(object: e));
    }
  }
}
