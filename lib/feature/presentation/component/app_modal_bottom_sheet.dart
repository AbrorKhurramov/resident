import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:resident/app_package/core_package.dart';

class AppModalBottomSheet extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool isExpand;

  const AppModalBottomSheet(
      {Key? key, required this.child, this.backgroundColor, bool? isExpand})
      : isExpand = isExpand ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isExpand
        ? Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Material(
              color: backgroundColor,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24)),
              child: child,
            ),
          )
        : Container(
            height: AppConfig.screenHeight(context) * 0.9,
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Material(
              color: backgroundColor,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24)),
              child: child,
            ),
          );
  }
}

Future<T> showAppModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool? isExpand,
  Color? backgroundColor,
  bool? enableDrag,
}) async {

  final result = await showCustomModalBottomSheet(
    context: context,
    builder: builder,
    enableDrag: enableDrag ?? true,
    barrierColor: Colors.black.withOpacity(0.6),
    containerWidget: (_, animation, child) =>
        AppModalBottomSheet(isExpand: isExpand, child: child),
  );
  return result;
}
