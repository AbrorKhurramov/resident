import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';

class FilterFloatBottom extends StatefulWidget {
  final Function onPressed;

  const FilterFloatBottom(this.onPressed, {Key? key}) : super(key: key);

  @override
  State<FilterFloatBottom> createState() => _FilterFloatBottomState();
}

class _FilterFloatBottomState extends State<FilterFloatBottom> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.c6000,
      splashColor: Colors.white,
      onPressed: () {
        widget.onPressed();
      },
      child: SvgPicture.asset('assets/icons/filter.svg'),
    );
  }
}
