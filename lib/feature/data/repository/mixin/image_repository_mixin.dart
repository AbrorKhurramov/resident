import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';

mixin ImageRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, ImageFile>> sendFile(
      {required XFile xFile, required CancelToken cancelToken}) async {
    Either<Exception, ImageFile> response = await appRemoteSource.sendFile(
      file: xFile,
      cancelToken: cancelToken,
    );

    return getEitherResponse<ImageFile>(response);
  }
}
