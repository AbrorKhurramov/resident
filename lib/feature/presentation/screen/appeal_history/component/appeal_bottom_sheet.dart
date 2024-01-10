import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/domain/entity/response/reg_application_reply.dart';
import 'package:resident/feature/presentation/component/app_image_component.dart';

class AppealBottomSheet extends StatefulWidget {
  final AppealResponse appeal;

  const AppealBottomSheet({required this.appeal, Key? key}) : super(key: key);

  @override
  State<AppealBottomSheet> createState() => _AppealBottomSheetState();
}

class _AppealBottomSheetState extends State<AppealBottomSheet> {
  late AppLocalizations _appLocalization;

  List<ImageFile>? imageFile;
  String content = '';

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          width: AppConfig.screenWidth(context),
          height: AppConfig.screenHeight(context),
          child: BlocBuilder<AppCubit, AppState>(builder: (context, appState) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
                  AppDimension.verticalSize_16,
                  Text(
                    widget.appeal.appealType.name.translate(
                            context.read<LanguageCubit>().state.languageCode) ??
                        '',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
                  ),
                  AppDimension.verticalSize_4,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appState.user!.getActiveApartment().getApartmentInfo(
                            context.read<LanguageCubit>().languageCode(),
                            _appLocalization.flat),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: AppColor.c3000, fontSize: 12.sf(context)),
                      ),
                    ],
                  ),
                  AppDimension.verticalSize_4,
                  Text(
                    appState.user!.getActiveApartment().complexInfo(),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: AppColor.c4000, fontSize: 14.sf(context)),
                  ),
                  AppDimension.verticalSize_32,
                  SizedBox(
                    height: 56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${_appLocalization.appeal_date.capitalize()}:',
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: AppColor.c3000, fontSize: 13.sf(context)),
                          ),
                        ),
                        AppDimension.horizontalSize_4,
                        Expanded(
                          flex: 1,
                          child: Text(
                            widget.appeal.createdDate.getDateWithHour(_appLocalization),
                            maxLines: 1,
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: AppColor.c4000, fontSize: 13.sf(context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: AppColor.c40000,
                  ),
                  SizedBox(
                    height: 56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${_appLocalization.status.capitalize()}:',
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: AppColor.c3000, fontSize: 13.sf(context)),
                          ),
                        ),
                        AppDimension.horizontalSize_4,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: _getStatusColor(widget.appeal.status),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                _getAppealStatusLabel(widget.appeal.status)
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontSize: 10.sf(context),
                                      color: Colors.white,
                                    ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: AppColor.c40000,
                  ),
                  AppDimension.verticalSize_24,
                  SizedBox(
                    width: AppConfig.screenWidth(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          _appLocalization.appeal.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: AppColor.c4000, fontSize: 12.sf(context)),
                        ),
                        AppDimension.verticalSize_8,
                        Text(
                          widget.appeal.content!,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: AppColor.c3000, fontSize: 14.sf(context)),
                        ),
                      ],
                    ),
                  ),
                  AppDimension.verticalSize_32,
                  _initImageContainer(),
                  AppDimension.verticalSize_24,
                  _initAnswer(widget.appeal.regApplicationReply!=null?RegApplicationReply.fromJson(widget.appeal.regApplicationReply):null),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(_appLocalization.close.toUpperCase(),style: TextStyle(fontSize: 14.sf(context))))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _initAnswer(dynamic appealAnswer) {
    if(appealAnswer==null) {
      return const SizedBox.shrink();
    } else {
      RegApplicationReply reply = appealAnswer;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: AppColor.c6000.withOpacity(0.1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  reply.createdDate,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: AppColor.c4000, fontSize: 12.sf(context)),
                ),
              ],
            ),
            AppDimension.verticalSize_8,
            Text(
              _appLocalization.answer_from_housing_and_communal_services.capitalize(),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: AppColor.c4000, fontSize: 12.sf(context)),
            ),
            AppDimension.verticalSize_8,
            Text(
                reply.content,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor.c3000, fontSize: 14.sf(context))),
          ],
        ),
      );
    }
  }

  String _getAppealStatusLabel(int appealStatusId) {
    switch (appealStatusId) {
      case 0:
        return AppealStatus.newStatus.getLabel(_appLocalization);
      case 1:
        return AppealStatus.inProgressStatus.getLabel(_appLocalization);
      case 2:
        return AppealStatus.confirmedStatus.getLabel(_appLocalization);
      case 3:
        return AppealStatus.notConfirmedStatus.getLabel(_appLocalization);
      default:
        return AppealStatus.completed.getLabel(_appLocalization);
    }
  }
  Color _getStatusColor(int status){
    switch(status){
      case 0: return AppColor.c6000;
      case 1:return AppColor.c70000;
      case 2: return AppColor.c7000;
      case 3: return AppColor.c50000;
      default: return AppColor.c4000;
    }
  }

  Widget _initImageContainer() {
    return SizedBox(
      width: AppConfig.screenWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _appLocalization.attached_files.toUpperCase(),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColor.c4000,
                  fontSize: 12.sf(context),
                ),
          ),
          AppDimension.verticalSize_8,
          const AppImageComponent(
            isCanRemove: false,
            isCanAdd: false,
          )
        ],
      ),
    );
  }
}
