import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_empty_card.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_header_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SurveyEmptyComponent extends StatefulWidget {
  const SurveyEmptyComponent({Key? key}) : super(key: key);

  @override
  State<SurveyEmptyComponent> createState() => _SurveyEmptyComponent();
}

class _SurveyEmptyComponent extends State<SurveyEmptyComponent> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyListCubit, SurveyListState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SurveyHeaderComponent(),
            Container(
              width: AppConfig.screenWidth(context),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: AppEmptyCard(
                  path: 'assets/icons/empty_survey.svg',
                  description: _appLocalization.empty_survey_description),
            ),
          ],
        );
      },
    );
  }
}
