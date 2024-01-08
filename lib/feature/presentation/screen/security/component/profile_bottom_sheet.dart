
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/bloc/app_image_cubit/app_image_state.dart';
import 'package:resident/feature/presentation/component/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/screen/security/component/profile_image_component.dart';

class ProfileBottomSheet extends StatefulWidget {
   const ProfileBottomSheet({Key? key}) : super(key: key);
  @override
  State<ProfileBottomSheet> createState() => _ProfileBottomSheetState();
}

class _ProfileBottomSheetState extends State<ProfileBottomSheet> {
  late AppLocalizations _appLocalization;
  List<ImageFile>? imageFile = [];
  final TextEditingController _newPhoneController = TextEditingController();

  final FocusNode _newPhoneFocus = FocusNode();
  final maskFormatter = MaskTextInputFormatter(mask: '(##) ### ## ##');
  @override
  void dispose() {
    super.dispose();
    _newPhoneController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SizedBox(
            width: AppConfig.screenWidth(context),
            height: AppConfig.screenHeight(context)*0.9,
            child: BlocBuilder<AppCubit, AppState>(builder: (context, appState) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
                    AppDimension.verticalSize_16,
                    Text(
                      _appLocalization.personal_data.capitalize(),
                      style: Theme.of(context).textTheme.headline2!.copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
                    ),
                    AppDimension.verticalSize_24,
                    AppTextField(
                      textFormField: TextFormField(
                        readOnly: true,
                        maxLength: 32,
                        textInputAction: TextInputAction.next,
                        style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 12.sf(context), color: AppColor.c9000),
                        decoration: InputDecoration(
                            isDense: true,
                            counterText: "",
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: appState.user?.lastName ?? '',
                            hintStyle:
                                Theme.of(context).textTheme.headline4!.copyWith(fontSize: 17.sf(context), color: AppColor.c9000)),
                      ),
                      borderColor: AppColor.c8000,
                      label: _appLocalization.last_name.toUpperCase(),
                      hintLabel: appState.user?.lastName ?? '',
                      labelColor: AppColor.c4000,
                    ),
                    AppDimension.verticalSize_24,
                    AppTextField(
                      textFormField: TextFormField(
                        readOnly: true,
                        maxLength: 32,
                        textInputAction: TextInputAction.next,
                        style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 12.sf(context), color: AppColor.c9000),
                        decoration: InputDecoration(
                            isDense: true,
                            counterText: "",
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: appState.user?.firstName ?? '',
                            hintStyle:
                                Theme.of(context).textTheme.headline4!.copyWith(fontSize: 17.sf(context), color: AppColor.c9000)),
                      ),
                      borderColor: AppColor.c8000,
                      label: _appLocalization.first_name.toUpperCase(),
                      hintLabel: appState.user?.firstName ?? '',
                      labelColor: AppColor.c4000,
                    ),
                    AppDimension.verticalSize_24,
                    AppTextField(
                      textFormField: TextFormField(
                        controller: _newPhoneController,
                        focusNode: _newPhoneFocus,
                        inputFormatters: [maskFormatter],
                        maxLength: 16,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 17.sf(context), color: AppColor.c9000),
                        decoration: InputDecoration(
                            isDense: true,
                            counterText: "",
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText:_getFormattedPhoneNumber(appState.user?.phone??""),
                            prefixIcon: Text(
                              "+998 ",
                              style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 17.sf(context), color: AppColor.c9000),
                            ),
                            hintStyle:
                            Theme.of(context).textTheme.headline2!.copyWith(fontSize: 17.sf(context), color: AppColor.c9000)),

                      ),
                      focusNode: _newPhoneFocus,
                      borderColor: AppColor.c8000,
                      label: _appLocalization.phone.toUpperCase(),
                      hintLabel: _appLocalization.phone.capitalize(),
                      labelColor: AppColor.c4000,
                    ),
                    AppDimension.verticalSize_24,
                    _initImageContainer(),
                    const Spacer(),
                    BlocBuilder<NotInternetCubit, bool>(
                      builder: (context, internetState) {
                        return BlocConsumer<ProfileCubit, ProfileState>(
                          listener: (context, state) {
                            if (state.stateStatus == StateStatus.success) {
                              Navigator.pop(context, true);

                              showSuccessFlushBar(
                                  context,
                                  state.response?.statusMessage.translate(context.read<LanguageCubit>().languageCode()) ??
                                      '');
                            }
                          },
                          builder: (context, profileState) {
                            return BlocBuilder<AppImageCubit, AppImageState>(builder: (context, imageState) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 36),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        onSurface: AppColor.c6000.withOpacity(0.15), primary: AppColor.c6000),
                                    onPressed:_validate(_newPhoneController.text)&&
                                        internetState && imageState.imageFile != null && imageState.imageFile!.isNotEmpty
                                            ? () {
                                                 context.read<ProfileCubit>().updateProfile(
                                                    appState.user!.firstName,
                                                    appState.user!.lastName,
                                                    _newPhoneController.text.isNotEmpty? _getPhoneNumber(_newPhoneController.text):appState.user?.phone??"",
                                                    context.read<AppImageCubit>().state.imageFile![0].id!);
                                              }
                                            : null,
                                    child: profileState.stateStatus == StateStatus.loading
                                        ? CupertinoActivityIndicator(radius: 12)
                                        : Text(_appLocalization.save.capitalize(),style: TextStyle(fontSize: 14.sf(context)))),
                              );
                            });
                          },
                        );
                      },
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
  bool _validate(String newPhone) {
    if(newPhone.length==14||newPhone.isEmpty) return true;
    return false;
  }
  String _getPhoneNumber(String text){
    String phone = text;
    phone = phone.replaceAll("(", "").replaceAll(")", "").replaceAll(" ", "");
    phone = "998$phone";
    return phone;
  }
  String _getFormattedPhoneNumber(String text){
    String phone = text;
    phone = phone.substring(3,phone.length);
    phone = "(${phone.substring(0,2)}) ${phone.substring(2,5)} ${phone.substring(5,7)} ${phone.substring(7,phone.length)}";
    return phone;
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
            _appLocalization.profile_image.toUpperCase(),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: AppColor.c4000,
                  fontSize: 12.sf(context),
                ),
          ),
          AppDimension.verticalSize_8,
          ProfileImageComponent(
            onAddImagePressed: (List<ImageFile> imageFile) => this.imageFile = imageFile,
            onRemoveImagePressed: (List<ImageFile> imageFile) => this.imageFile = imageFile,
          )
        ],
      ),
    );
  }
}
