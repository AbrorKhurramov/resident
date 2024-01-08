import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/bloc/app_image_cubit/app_image_state.dart';
import 'package:resident/feature/presentation/component/app_image_component.dart';
import 'package:resident/main.dart';

class CreateAppealBottomSheet extends StatefulWidget {
  final AppealType appealType;

  const CreateAppealBottomSheet({required this.appealType, Key? key}) : super(key: key);

  @override
  State<CreateAppealBottomSheet> createState() => _CreateAppealBottomSheetState();
}

class _CreateAppealBottomSheetState extends State<CreateAppealBottomSheet> {
  late AppLocalizations _appLocalization;
  final TextEditingController _editingController = TextEditingController();

  List<ImageFile> imageFile = [];
  String content = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  void dispose() {
    super.dispose();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          width: AppConfig.screenWidth(context),
          height: AppConfig.screenHeight(context) * 0.9,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
              AppDimension.verticalSize_16,
              Text(
                widget.appealType.name.translate(context.read<LanguageCubit>().languageCode())!,
                style: Theme.of(context).textTheme.headline2!.copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
              ),
              Text(
                context.read<AppCubit>().state.user!.getActiveApartment().complex?.name ?? '',
                style: Theme.of(context).textTheme.headline3!.copyWith(color: AppColor.c4000, fontSize: 14.sf(context)),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context
                        .read<AppCubit>()
                        .getActiveApartment()
                        .getApartmentInfo(context.read<LanguageCubit>().languageCode(), _appLocalization.flat),
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: AppColor.c3000, fontSize: 12.sf(context)),
                  ),
                ],
              ),
              AppDimension.verticalSize_12,
              _initTextField(),
              AppDimension.verticalSize_12,
              _initImageContainer(),
              const Spacer(),
              BlocConsumer<CreateAppealCubit, CreateAppealState>(listener: (context, state) {
                if (state.stateStatus == StateStatus.success) {
                  Navigator.of(context).pop();
                  showSuccessFlushBar(context, state.response!.statusMessage.translate(context
                      .read<LanguageCubit>()
                      .state
                      .languageCode) ??
                      '');
                } else if (state.stateStatus == StateStatus.failure) {
                  MyApp.failureHandling(context, state.failure!);
                }
              }, builder: (context, state) {
                return BlocBuilder<AppImageCubit, AppImageState>(builder: (context, imageState) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onSurface: AppColor.c6000.withOpacity(0.15), primary: AppColor.c6000),
                      onPressed: _editingController.text.isNotEmpty &&imageState.stateStatus!=StateStatus.loading && state.stateStatus != StateStatus.loading
                          ? () {
                              _createAppeal();
                            }
                          : null,
                      child: state.stateStatus == StateStatus.loading
                          ? CupertinoActivityIndicator(radius: 12)
                          : Text(_appLocalization.send.toUpperCase(),style: TextStyle(fontSize: 14.sf(context))));
                });
              })
            ],
          ),
        ),
      ),
    );
  }

  void _createAppeal() {
    context.read<CreateAppealCubit>().createAppeal(AppealRequest(
        apartmentId: context.read<AppCubit>().state.user!.getActiveApartment().id,
        content: content,
        imageFileId:  imageFile.isNotEmpty?imageFile.map((e) => e.id!).toList():[],
        type: widget.appealType.id));
  }

  Widget _initImageContainer() {
    return Container(
      width: AppConfig.screenWidth(context),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        border: Border.all(
          color: AppColor.c8000,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _appLocalization.attach_file.toUpperCase(),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: AppColor.c4000,
                  fontSize: 12.sf(context),
                ),
          ),
          AppDimension.verticalSize_8,
          AppImageComponent(
            isCanRemove: true,
            isCanAdd: true,
            onAddImagePressed: (List<ImageFile> imageFile) => this.imageFile = imageFile,
            onRemoveImagePressed: (List<ImageFile> imageFile) => this.imageFile = imageFile,
          )
        ],
      ),
    );
  }

  Widget _initTextField() {
    return Container(
      height: 270,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        border: Border.all(
          color: AppColor.c8000,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _appLocalization.appeal.capitalize(),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: AppColor.c4000,
                  fontSize: 12.sf(context),
                ),
          ),
          TextField(
            controller: _editingController,
            keyboardType: TextInputType.multiline,
            maxLines: 9,
            textInputAction: TextInputAction.done,
            onChanged: (String changedText) {
              content = changedText;
            },
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: AppColor.c3000,
                  fontSize: 17.sf(context),
                ),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _appLocalization.write_appeal,
                hintStyle: Theme.of(context).textTheme.headline4!.copyWith(color: AppColor.c3000, fontSize: 17.sf(context))),
          )
        ],
      ),
    );
  }
}
