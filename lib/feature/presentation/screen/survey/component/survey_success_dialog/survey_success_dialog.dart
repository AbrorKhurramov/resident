import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/presentation/component/app_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../../bloc/survey_list_cubit/survey_list_cubit.dart';

class SurveySuccessDialog extends StatefulWidget {
  final bool isSuccess;
final BuildContext surveyContext;

const SurveySuccessDialog(this.isSuccess, {Key? key,required this.surveyContext}) : super(key: key);

  @override
  State<SurveySuccessDialog> createState() => _SurveySuccessDialogState();
}


class _SurveySuccessDialogState extends State<SurveySuccessDialog> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _surveyClose();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: SizedBox(
                width: AppConfig.screenWidth(context),
                height: AppConfig.screenHeight(context) * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                          'assets/icons/modal_bottom_top_line.svg'),
                      AppDimension.verticalSize_16,
                      Container(
                        width: 109,
                        height: 109,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.isSuccess
                                ? AppColor.c100000
                                : AppColor.c200000),
                        child: widget.isSuccess
                            ? const Icon(
                                Icons.check,
                                size: 56,
                              )
                            : const Icon(Icons.clear, color: Colors.white, size: 56),
                      ),
                      AppDimension.verticalSize_24,
                      Text(
                        widget.isSuccess
                            ? _appLocalization.thanks_for_vote.toUpperCase()
                            : _appLocalization.something_went_wrong
                                .toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                      const Spacer(),
                      AppButton(
                        isLoading: false,
                        isSmallSize: true,
                        onClick: () {
                          _surveyClose();
                        },
                        label: _appLocalization.close.toUpperCase(),
                        primaryColor: AppColor.c60000,
                        onPrimaryColor: AppColor.c60000,
                        labelColor: Colors.black,
                      ),
                      Visibility(
                        visible: false,
                        child: Column(
                          children: [
                            AppDimension.verticalSize_16,
                            AppButton(
                              isLoading: false,
                              isSmallSize: true,
                              onClick: () {
                                _showResult();
                              },
                              label: _appLocalization.find_out_results
                                  .toUpperCase(),
                              primaryColor: AppColor.c6000,
                              onPrimaryColor: Colors.white,
                              labelColor: Colors.white,
                            ),
                            AppDimension.verticalSize_32
                          ],
                        ),
                      )
                    ],
                  ),
                ))),
      ),
    );
  }

  _surveyClose() {
    widget.surveyContext.read<SurveyListCubit>().getSurveys();

    Navigator.pop(context);
    Navigator.pop(context, true);


  }

  _showResult() {
    widget.surveyContext.read<SurveyListCubit>().getSurveys();


    Navigator.pop(context, true);
  }
}
