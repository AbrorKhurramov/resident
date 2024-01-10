import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/presentation/component/app_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SurveyCompleted extends StatefulWidget {
  final bool isSuccess;

  const SurveyCompleted(this.isSuccess, {Key? key}) : super(key: key);

  @override
  State<SurveyCompleted> createState() => _SurveyCompletedState();
}

class _SurveyCompletedState extends State<SurveyCompleted> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SvgPicture.asset('assets/images/bottom_dialog_top_control.svg'),
          AppDimension.verticalSize_64,
          Container(
            width: 109,
            height: 109,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isSuccess ? AppColor.c100000 : AppColor.c200000),
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
                : _appLocalization.something_went_wrong.toUpperCase(),
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
              _surveyClose(context);
            },
            label: _appLocalization.close,
            primaryColor: AppColor.c60000,
            onPrimaryColor: AppColor.c60000,
            labelColor: Colors.black,
          ),
          widget.isSuccess
              ? Column(
                  children: [
                    AppDimension.verticalSize_16,
                    AppButton(
                      isLoading: false,
                      isSmallSize: true,
                      onClick: () {
                        _showResult(context);
                      },
                      label: _appLocalization.find_out_results.capitalize(),
                      primaryColor: AppColor.c6000,
                      onPrimaryColor: Colors.white,
                      labelColor: Colors.white,
                    ),
                    AppDimension.verticalSize_32
                  ],
                )
              : AppDimension.defaultSize
        ],
      ),
    );
  }

  _surveyClose(context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  _showResult(context) async {
    Navigator.pop(context);
  }
}
