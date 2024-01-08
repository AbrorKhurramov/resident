import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class SendFileUseCase extends UseCase<ImageFile, SendFileUseCaseParams> {
  final ImageRepository imageRepository;

  SendFileUseCase(this.imageRepository);

  @override
  Future<Either<Failure, ImageFile>> call(SendFileUseCaseParams params) {
    return imageRepository.sendFile(xFile: params.xFile, cancelToken: params.cancelToken);
  }
}

class SendFileUseCaseParams extends Equatable {
  final XFile xFile;
  final CancelToken cancelToken;

  const SendFileUseCaseParams(this.xFile, this.cancelToken);

  SendFileUseCaseParams copyWith({XFile? xFile, CancelToken? cancelToken}) {
    return SendFileUseCaseParams(
      xFile ?? this.xFile,
      cancelToken ?? this.cancelToken,
    );
  }

  @override
  List<Object?> get props => [xFile, cancelToken];
}
