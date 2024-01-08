import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';

abstract class LanguageRepository {
  Future<Either<Failure, String?>> getLanguageCode();

  Future<Either<Failure, void>> setLanguageCode(String languageCode);
}
