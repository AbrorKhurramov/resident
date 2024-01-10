import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class RangeDateComponent extends StatelessWidget {
  final String title;
  final String? chosenDate;
  final VoidCallback onPressed;

  const RangeDateComponent(
      {Key? key, required this.title, this.chosenDate, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      onTap: onPressed,
      child: Container(
        width: AppConfig.screenWidth(context),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.c8000),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: AppColor.c4000, fontSize: 12.sf(context)),
            ),
            AppDimension.verticalSize_8,
            Text(
              chosenDate ?? '10.12.2021',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AppColor.c3000, fontSize: 17.sf(context)),
            )
          ],
        ),
      ),
    );
  }
}
