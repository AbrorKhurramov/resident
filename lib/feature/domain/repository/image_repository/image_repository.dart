import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

abstract class ImageRepository {
  Future<Either<Failure, ImageFile>> sendFile({
    required XFile xFile,
    required CancelToken cancelToken,
  });
}
