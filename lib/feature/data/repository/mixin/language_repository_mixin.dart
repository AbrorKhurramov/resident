import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/data/data_source/shared_preference_source/app_preference_source.dart';

mixin LanguageRepositoryMixin {
  late final AppPreferenceSource appSharedPreferenceSource;

  Future<Either<Failure, String?>> getLanguageCode() async {
    try {
      return Right(await appSharedPreferenceSource.getLanguageCode());
    } catch (e) {
      return Left(ExceptionFailure(object: e));
    }
  }

  Future<Either<Failure, void>> setLanguageCode(String languageCode) async {
    try {
      return Right(
          await appSharedPreferenceSource.setLanguageCode(languageCode));
    } catch (e) {
      return Left(ExceptionFailure(object: e));
    }
  }
}
