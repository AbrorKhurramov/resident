import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class SurveyItem extends StatefulWidget {
  final SurveyList survey;
  final VoidCallback onClick;

  const SurveyItem({Key? key, required this.survey, required this.onClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SurveyItemState();
  }
}

class _SurveyItemState extends State<SurveyItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.grey, backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onPressed: widget.onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                    widget.survey.name.translate(
                            context.read<LanguageCubit>().state.languageCode) ??
                        '',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: AppColor.c4000, fontSize: 14.sf(context))),
              ),
              AppDimension.verticalSize_12,
              SizedBox(
                width: 24,
                height: 24,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/right_arrow.svg",
                    width: 6,
                    height: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
