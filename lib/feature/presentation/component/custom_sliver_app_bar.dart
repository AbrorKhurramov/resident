import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';

class CustomSliverAppBar extends StatelessWidget{
  final String label;
  final VoidCallback? voidCallback;

  const CustomSliverAppBar({Key? key, required this.label, this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leadingWidth: 80,
      centerTitle: true,
      title: Text(
        label,
        style: Theme.of(context).textTheme.headline2!.copyWith(color: AppColor.c4000, fontSize: 17),
      ),
      leading: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 24),
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Center(child: SvgPicture.asset('assets/icons/left_app_bar.svg')),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: CircleBorder(),
            fixedSize: Size(32, 32),
            primary: Colors.white,
            elevation: 0,
            onPrimary: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}