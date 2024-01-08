import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/feature/presentation/bloc/story/story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit(StoryState initialState) : super(initialState);

  void changeActiveIndex(TapDownDetails details,double screenWidth ) {

    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      if(state.activeIndex>=1) {
        emit(state.copyWith(activeIndex: state.activeIndex - 1));
      }
    }
    else if (dx > 2 * screenWidth / 3) {
      emit(state.copyWith(activeIndex: state.activeIndex + 1));
    }
  }
  void increaseActiveIndex() {

    emit(state.copyWith(activeIndex: state.activeIndex + 1));

  }


}
