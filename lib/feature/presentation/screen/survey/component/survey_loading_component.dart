import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_header_component.dart';

class SurveyLoadingComponent extends StatefulWidget {
  const SurveyLoadingComponent({Key? key}) : super(key: key);

  @override
  State<SurveyLoadingComponent> createState() => _SurveyLoadingComponentState();
}

class _SurveyLoadingComponentState extends State<SurveyLoadingComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyListCubit, SurveyListState>(
      builder: (context, state) {
        return Stack(
          children: const [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SurveyHeaderComponent(),
            ),
            Positioned.fill(child: Center(child: CircularProgressIndicator())),
          ],
        );
      },
    );
  }
}
