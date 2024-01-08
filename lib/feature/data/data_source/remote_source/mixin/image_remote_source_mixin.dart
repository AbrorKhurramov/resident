import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';

mixin ImageRemoteSourceMixin implements BaseRequest {
  Future<Either<Exception, ImageFile>> sendFile({
    required XFile file,
    required CancelToken cancelToken,
  }) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    return post(
      '/file',
      data: formData,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<ImageFile>(json)).mapRight((right) {
      return right;
    });
  }
}
