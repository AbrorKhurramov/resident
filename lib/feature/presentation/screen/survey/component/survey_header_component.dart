import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SurveyHeaderComponent extends StatefulWidget {
  const SurveyHeaderComponent({Key? key}) : super(key: key);

  @override
  State<SurveyHeaderComponent> createState() => _SurveyHeaderComponentState();
}

class _SurveyHeaderComponentState extends State<SurveyHeaderComponent> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyListCubit, SurveyListState>(
        builder: (context, state) {
      if (state.response != null && state.response!.data.isNotEmpty) {
        return SizedBox(
          height: 120,
          child: Stack(
            children: [
              Positioned(
                top: 4,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      fixedSize: Size(32, 32),
                      primary: Colors.white,
                      elevation: 0,
                      onPrimary:
                          Theme.of(context).primaryColor, // <-- Splash color
                    ),
                    child: Center(
                      child: SvgPicture.asset('assets/icons/left_app_bar.svg'),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(64, 64),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          primary: Colors.white,
                          onPrimary: Theme.of(context).primaryColor,
                          elevation: 0,
                        ),
                        child: SvgPicture.asset('assets/icons/votes.svg'),
                      ),
                      AppDimension.verticalSize_16,
                      Text(
                        _appLocalization.survey.capitalize(),
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return CustomAppBar(label: _appLocalization.survey.capitalize());
    });
  }
}
