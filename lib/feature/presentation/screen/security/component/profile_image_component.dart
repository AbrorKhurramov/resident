
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/domain/entity/response/image_file.dart';
import 'package:resident/feature/presentation/bloc/app_image_cubit/app_image_state.dart';

class ProfileImageComponent extends StatefulWidget {
  final Function(List<ImageFile> imageFiles)? onAddImagePressed;
  final Function(List<ImageFile> imageFiles)? onRemoveImagePressed;

  const ProfileImageComponent({Key? key, this.onAddImagePressed, this.onRemoveImagePressed}) : super(key: key);

  @override
  State<ProfileImageComponent> createState() => _ProfileImageComponentState();
}

class _ProfileImageComponentState extends State<ProfileImageComponent> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppImageCubit, AppImageState>(listener: (context, state) {
      if (state.stateStatus == StateStatus.success) {
        widget.onAddImagePressed!(state.imageFile!);
      } else {}
    }, builder: (context, state) {
      return SizedBox(
        height: 90,
        child: state.imageFile != null && state.imageFile!.isEmpty
            ? _initAddImageContainer()
            : ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.imageFile!.length,
                itemBuilder: (context, index) {
                  return _initImageContainer(
                    state.imageFile![index],
                    index,
                  );
                },
                separatorBuilder: (context, index) => AppDimension.horizontalSize_16),
      );
    });
  }

  Widget _initAddImageContainer() {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: () {
        _picker.pickImage(source: ImageSource.gallery, imageQuality: 25).then((value) {
          if (value != null) context.read<AppImageCubit>().addImage(value);
        });
      },
      child: BlocBuilder<AppImageCubit, AppImageState>(
        builder: (context, state) {
          return Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: AppColor.c6000.withOpacity(0.1),
            ),
            child: state.stateStatus == StateStatus.loading
                ? const SizedBox(
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

  Widget _initImageContainer(ImageFile imageFile, int index) {
    return ClipRRect(
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
               // '${imageFile.path}',
                '${AppRemoteSourceImpl.BASE_URL}/file/download/${imageFile.guid}.${imageFile.extension}',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 4,
                right: 4,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  onTap: () {
                    context.read<AppImageCubit>().removeImage(index);
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/trash.svg',
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
