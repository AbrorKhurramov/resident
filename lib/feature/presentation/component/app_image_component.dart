
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/domain/entity/response/image_file.dart';
import 'package:resident/feature/presentation/bloc/app_image_cubit/app_image_state.dart';

class AppImageComponent extends StatefulWidget {
  final bool isCanRemove;
  final bool isCanAdd;
  final int? fixedImageSize;
  final Function(List<ImageFile> imageFiles)? onAddImagePressed;
  final Function(List<ImageFile> imageFiles)? onRemoveImagePressed;

  const AppImageComponent(
      {Key? key,
      required this.isCanRemove,
      required this.isCanAdd,
      this.fixedImageSize,
      this.onAddImagePressed,
      this.onRemoveImagePressed})
      : super(key: key);

  @override
  State<AppImageComponent> createState() => _AppImageComponentState();
}

class _AppImageComponentState extends State<AppImageComponent> {
  final ImagePicker _picker = ImagePicker();
  List<String> imageFileIds = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppImageCubit, AppImageState>(
        listener: (context, state) async{
      if (state.stateStatus == StateStatus.success) {
       await widget.onAddImagePressed!(state.imageFile!);
      } else {}
    }, builder: (context, state) {
      return SizedBox(
        height: 90,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _getItemCount(state.imageFile),
            itemBuilder: (context, index) {
              if (widget.isCanAdd &&
                  index == 0) {
                return _initAddImageContainer();
              }
              return _initImageContainer(
                state.imageFile![widget.isCanAdd?index-1:index],
                index,widget.isCanAdd
              );
            },
            separatorBuilder: (context, index) =>
                AppDimension.horizontalSize_16),
      );
    });
  }

  int _getItemCount(List<ImageFile>? imageFile) {
    if (widget.fixedImageSize != null) {
      return widget.fixedImageSize!;
    } else if (widget.isCanAdd) {
      return imageFile != null ? imageFile.length + 1 : 1;
    }

    return imageFile?.length ?? 0;
  }

  Widget _initAddImageContainer() {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () async{
      await  _picker
            .pickImage(source: ImageSource.gallery, imageQuality: 25)
            .then((value) {
          if (value != null)  context.read<AppImageCubit>().addImage(value);
        });
      },
      child: BlocBuilder<AppImageCubit, AppImageState>(
        builder: (context, state) {
          return Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: AppColor.c6000.withOpacity(0.1),
            ),
            child: state.stateStatus == StateStatus.loading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SvgPicture.asset(
                    'assets/icons/add_image.svg',
                    fit: BoxFit.none,
                  ),
          );
        },
      ),
    );
  }

  Widget _initImageContainer(ImageFile imageFile, int index,bool isAdd) {
    return GestureDetector(
      onTap: () async{
       if(!isAdd) {
          await showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                  child: SizedBox(
                    width: 200,
                    child: Image.network(
                      '${AppRemoteSourceImpl.BASE_URL}/file/download/${imageFile.guid}.${imageFile.extension}',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              });
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 90,
          height: 90,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Image.network(
                 '${AppRemoteSourceImpl.BASE_URL}/file/download/${imageFile.guid}.${imageFile.extension}',
                  fit: BoxFit.cover,
                ),
              ),
              widget.isCanRemove
                  ? Positioned(
                      top: 4,
                      right: 4,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onTap: () {
                          context.read<AppImageCubit>().removeImage(index-1);
                          // widget.onRemoveImagePressed!(context.read<AppImageCubit>().state.imageFile!);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/trash.svg',
                          ),
                        ),
                      ))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
