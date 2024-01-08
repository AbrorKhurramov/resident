import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';

late Flushbar flushBar;

void dismissFlushBar() async {
  try {
    return flushBar.dismiss();
  } catch (exception) {}
}

void showErrorFlushBar(context, String message) {
  flushBar = Flushbar(
    margin: EdgeInsets.symmetric(horizontal: 24),
    borderRadius: BorderRadius.all(Radius.circular(16)),
    backgroundColor: AppColor.c50000,
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: 4),
    animationDuration: Duration(milliseconds: 500),
    padding: EdgeInsets.all(12),
    messageText: Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
            'assets/icons/error.svg',
            color: Colors.white,
          ),
        ),
        AppDimension.horizontalSize_8,
        Expanded(
          child: Text(
            message.capitalize(),
            style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white, fontSize: 14.sf(context)),
          ),
        )
      ],
    ),
  );

  flushBar.show(context);
}

void showSuccessFlushBar(context, String message) {
  flushBar = Flushbar(
    margin: EdgeInsets.symmetric(horizontal: 24),
    borderRadius: BorderRadius.all(Radius.circular(16)),
    backgroundColor: Colors.black.withOpacity(0.85),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: 4),
    animationDuration: Duration(milliseconds: 500),
    padding: EdgeInsets.all(12),
    messageText: Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset('assets/icons/success.svg'),
        ),
        AppDimension.horizontalSize_8,
        Expanded(
          child: Text(
            message.capitalize(),
            style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white, fontSize: 14.sf(context)),
          ),
        )
      ],
    ),
  );

  flushBar.show(context);
}
