import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/domain/entity/response/image_file.dart';

class AppImageState extends Equatable {
  final StateStatus stateStatus;
  final List<ImageFile>? imageFile;
  final Failure? failure;

  const AppImageState({required this.stateStatus, this.imageFile, this.failure});

  AppImageState copyWith({StateStatus? stateStatus, List<ImageFile>? imageFile, Failure? failure}) {
    return AppImageState(
      stateStatus: stateStatus ?? this.stateStatus,
      imageFile: imageFile ?? this.imageFile,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        stateStatus,
        imageFile,
        failure,
      ];
}
