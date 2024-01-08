import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_component.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_header_component.dart';
import 'package:resident/feature/presentation/screen/survey/component/vote_component.dart';

class SurveyListComponent extends StatefulWidget {
  const SurveyListComponent({Key? key}) : super(key: key);
  @override
  State<SurveyListComponent> createState() => _SurveyListComponentState();
}

class _SurveyListComponentState extends State<SurveyListComponent>
    with AutomaticKeepAliveClientMixin {
  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SurveyListCubit, SurveyListState>(
        builder: (context, state) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: SurveyHeaderComponent(),
            )
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async{
            context.read<SurveyListCubit>().getSurveys();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children:  [
                VoteComponent(surveyContext: context),
                AppDimension.verticalSize_32,
                SurveyComponent(surveyContext: context)
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
