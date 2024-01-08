import 'package:equatable/equatable.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class StoryState extends Equatable {
  final List<Newness> list;
  final int activeIndex;

  const StoryState({required this.list, required this.activeIndex});

  StoryState copyWith({List<Newness>? list, int? activeIndex}) {
    return StoryState(list: list ?? this.list, activeIndex: activeIndex ?? this.activeIndex);
  }

  @override
  List<Object?> get props => [list, activeIndex];
}
