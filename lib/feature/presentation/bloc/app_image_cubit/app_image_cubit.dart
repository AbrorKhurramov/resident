import 'package:image_picker/image_picker.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/domain/entity/response/image_file.dart';
import 'package:resident/feature/presentation/bloc/app_image_cubit/app_image_state.dart';
import 'package:either_dart/either.dart';

class AppImageCubit extends RepositoryCubit<AppImageState> {
  final SendFileUseCase sendFileUseCase;

  AppImageCubit({required this.sendFileUseCase, List<ImageFile>? imageFile})
      : super(AppImageState(stateStatus: StateStatus.initial, imageFile: imageFile));

  void addImage(XFile chosenImageFile) {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    sendFileUseCase.call(SendFileUseCaseParams(chosenImageFile, cancelToken)).fold(
        (left) => emit(state.copyWith(stateStatus: StateStatus.failure, failure: left)),
        (right) {
         var a = state.imageFile??[];
         a.insert(0, right);
          emit(state.copyWith(
              stateStatus: StateStatus.success,
              imageFile:a,
            ));
        });
  }

  void removeImage(int index) {
    List<ImageFile> list = [...state.imageFile!];
    list.removeAt(index);
    emit(state.copyWith(imageFile: [...list]));
  }
}
