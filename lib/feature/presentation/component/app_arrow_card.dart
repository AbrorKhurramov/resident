import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class AppArrowCard extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Color? bgColor;
  final VoidCallback onPressed;

  const AppArrowCard(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.labelColor,
      this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          fixedSize: Size(double.infinity, 64),
          onPrimary: bgColor != null ? Colors.white : Colors.blue,
          primary: bgColor ?? Colors.white,
          elevation: 0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: labelColor ?? AppColor.c4000, fontSize: 14.sf(context)),
            ),
            SvgPicture.asset('assets/icons/right_arrow.svg',
                color: bgColor != null ? Colors.white : null),
          ],
        ),
      ),
    );
  }
}
