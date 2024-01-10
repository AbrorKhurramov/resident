import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class LanguageArrowCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String desc;
  const LanguageArrowCard(
      {Key? key,
        required this.label,
        required this.desc,
       required this.onPressed,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blue, shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ), backgroundColor: Colors.white,
          fixedSize: const Size(double.infinity, 64),
          elevation: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color:  AppColor.c4000, fontSize: 14.sf(context)),
            ),
            Row(
              children: [
                Text(
                  desc.capitalize(),
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color:  AppColor.c4000, fontSize: 14.sf(context)),
                ),
                AppDimension.horizontalSize_8,
                SvgPicture.asset('assets/icons/right_arrow.svg',
                    color: null),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
