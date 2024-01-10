import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class InitInfoItemWidget extends StatelessWidget {
  const InitInfoItemWidget({Key? key,required this.path,required this.desc,required this.info}) : super(key: key);
 final String path;
 final String desc;
 final String info;



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration:
          const BoxDecoration(shape: BoxShape.circle, color: AppColor.c6000),
          child: Center(
            child: SvgPicture.asset(
              path,
              color: Colors.white,
              fit: BoxFit.none,
            ),
          ),
        ),
        AppDimension.horizontalSize_8,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              desc.capitalize(),
              style: Theme
                  .of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: AppColor.c3000, fontSize: 11.sf(context)),
            ),
            Text(info,
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: AppColor.c4000, fontSize: 14.sf(context))),
          ],
        )
      ],
    );
  }
}
