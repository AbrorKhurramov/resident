import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';

abstract class PinCodeRepository {
  Future<Either<Failure, void>> setPinCode(String pinCode);

  Future<Either<Failure, void>> removePinCode();

  Future<Either<Failure, String?>> getPinCode();
}
