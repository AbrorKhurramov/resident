import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/screen/story/component/story_page_linear_component.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StoryPageLinearListComponent extends StatefulWidget {
  const StoryPageLinearListComponent({Key? key}) : super(key: key);

  @override
  State<StoryPageLinearListComponent> createState() =>
      _StoryPageLinearListComponentState();
}

class _StoryPageLinearListComponentState
    extends State<StoryPageLinearListComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, StoryState>(
      builder: (context, state) {
        return SizedBox(
          height: 2,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: (AppConfig.screenWidth(context) -
                          48 -
                          2 * (state.list.length - 1)) /
                      state.list.length,
                  child: state.activeIndex == index
                      ? StoryPageLinearComponent()
                      : _initDefaultLinear(state.activeIndex > index),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 2);
              },
              itemCount: state.list.length),
        );
      },
    );
  }

  Widget _initDefaultLinear(bool isViewed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: isViewed ? Colors.white : Colors.white.withOpacity(0.36),
      ),
    );
  }
}
