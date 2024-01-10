import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_empty_component.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_list_component.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_loading_component.dart';

import '../../app_route/app_route_name.dart';

class SurveyScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: AppRouteName.surveyScreen),
        builder: (context) {
      return BlocProvider(
        create: (_) => getIt<SurveyListCubit>(),
        child: const SurveyScreen(),
      );
    });
  }

  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SurveyListCubit>().getSurveys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/part_third_gradient.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<SurveyListCubit, SurveyListState>(
            builder: (context, state) {
              if (state.stateStatus == StateStatus.loading) {
                return const SurveyLoadingComponent();
              }

              if (state.stateStatus == StateStatus.success &&
                  state.surveyList.isEmpty &&
                  state.voteList.isEmpty) {
                return const SurveyEmptyComponent();
              }

              if (state.stateStatus == StateStatus.failure) {
                return AppDimension.defaultSize;
              }

              return const SurveyListComponent();
            },
          ),
        ),
      ),
    );
  }
}
