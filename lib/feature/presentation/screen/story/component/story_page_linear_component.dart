import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StoryPageLinearComponent extends StatefulWidget {
  const StoryPageLinearComponent({Key? key}) : super(key: key);

  @override
  State<StoryPageLinearComponent> createState() => _StoryPageLinearComponentState();
}

class _StoryPageLinearComponentState extends State<StoryPageLinearComponent> {
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (timer) {
     context.read<StoryCubit>().increaseActiveIndex();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, StoryState>(
      builder: (context, state) {
        return LinearPercentIndicator(
          animation: true,
          lineHeight: 2,
          animationDuration: 2500,
          percent: 1,
          padding: EdgeInsets.zero,
          barRadius: const Radius.circular(24),
          backgroundColor: Colors.white.withOpacity(0.36),
          progressColor: Colors.white,
        );
      },
    );
  }
}
