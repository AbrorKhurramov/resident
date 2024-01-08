import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_button.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/survey_bottom_dialog.dart';

class VotePageViewItem extends StatefulWidget {
  final SurveyList vote;
BuildContext surveyContext;
   VotePageViewItem({Key? key, required this.vote,required this.surveyContext}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VotePageViewItemState();
  }
}

class _VotePageViewItemState extends State<VotePageViewItem> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: AppColor.c6000),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              widget.vote.name.translate(
                      context.read<LanguageCubit>().state.languageCode) ??
                  '',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white, fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
                widget.vote.description.translate(
                        context.read<LanguageCubit>().state.languageCode) ??
                    '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                    height: 1.3)),
          ),
          AppButton(
            isLoading: false,
            isSmallSize: false,
            primaryColor: Colors.white,
            onPrimaryColor: Colors.white,
            onClick: () {
              _onClickQuizPageViewItem();
            },
            label: widget.vote.isAnswered
                ? _appLocalization.see_result.capitalize()
                : _appLocalization.vote.capitalize(),
            labelColor: AppColor.c4000,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(_appLocalization.you_must_vote_before.capitalize(),
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 11,
                      height: 1.3)),
              const SizedBox(height: 4),
              Text(widget.vote.expiryDate.getDateWithHour(_appLocalization),
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white, fontSize: 12, height: 1.5)),
            ],
          )
        ],
      ),
    );
  }

  // _getFormattedDate(String date) {
  //   DateTime createdDate = date.parseDateTime();
  //
  //   return '${createdDate.day} ${createdDate.getMonthLabel(_appLocalization)} ${createdDate.year}, ${createdDate.getHourFormat()}:${createdDate.getMinuteFormat()}';
  // }

  _onClickQuizPageViewItem() {
    showAppModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) {
            return SurveyCubit(
                getSurveyByIdUseCase: getIt<GetSurveyByIdUseCase>(),
                setSurveyUseCase: getIt<SetSurveyUseCase>(),
                surveyState: SurveyState(
                  stateStatus: StateStatus.initial,
                  answerSurveyStatus: StateStatus.initial,
                  currentSurvey: widget.vote,
                ));
          },
          child: SurveyBottomDialog(surveyContext: widget.surveyContext),
        );
      },
    ).then((value) => (){
      print("Survey bottom dialog then");
      print("VALUE"+value.toString());
          if (value != null && value == true) {
            context.read<SurveyListCubit>().getSurveys();
          }
        });
  }
}
