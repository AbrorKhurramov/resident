import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/vote_page_view_item.dart';

class VoteComponent extends StatefulWidget {
   VoteComponent({Key? key,required this.surveyContext}) : super(key: key);
BuildContext surveyContext;
  @override
  State<StatefulWidget> createState() {
    return _VoteComponentState();
  }
}

class _VoteComponentState extends State<VoteComponent> {
  int activePos = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyListCubit, SurveyListState>(
        builder: (context, state) {
      return Container(
        margin: EdgeInsets.only(top: 20),
        height: 328,
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Flexible(
            child: SizedBox(
              height: 280,
              child: PageView.builder(
                onPageChanged: (int pos) {
                  setState(() {
                    activePos = pos;
                  });
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, pos) {
                  if (state.response!.currentPage + 1 !=
                          state.response!.totalPages &&
                      pos == state.voteList.length &&
                      state.voteList.isNotEmpty) {
                    if (state.stateStatus != StateStatus.paginationLoading &&
                        state.stateStatus != StateStatus.paginationFailure) {
                      context.read<SurveyListCubit>().getPaginationSurveys();
                    }

                    if (state.stateStatus == StateStatus.paginationFailure) {
                      return AppDimension.defaultSize;
                    }
                    return Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: VotePageViewItem(vote: state.voteList[pos],surveyContext: widget.surveyContext));
                },
                itemCount: state.response != null &&
                        state.response!.currentPage + 1 <
                            state.response!.totalPages &&
                        state.voteList.isNotEmpty
                    ? state.voteList.length + 1
                    : state.voteList.length,
              ),
            ),
          ),
          Visibility(
            child: Container(
              margin: EdgeInsets.only(top: 16, left: 16, right: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.white),
              height: 32,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _initDotList(activePos, state.voteList.length),
              ),
            ),
            visible: state.voteList.length > 1 && state.voteList.length < 12,
          ),
        ]),
      );
    });
  }

  _initDotList(int activePos, int listLength) {
    List<Widget> list = [];

    if (listLength <= 1) return list;

    for (int i = 0; i < listLength; i++) {
      i == activePos ? list.add(_initDot(true)) : list.add(_initDot(false));
    }

    return list;
  }

  _initDot(bool active) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SvgPicture.asset(
        active
            ? "assets/icons/quiz_page_view_item_active_dot.svg"
            : "assets/icons/quiz_page_view_item_un_active_dot.svg",
      ),
    );
  }
}
