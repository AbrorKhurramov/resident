import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/core/util/app_dimension.dart';

class PinCodeImage extends StatelessWidget {
  const PinCodeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppDimension.verticalSize_24,
        AppDimension.verticalSize_24,
        Center(
          child: LimitedBox(
            maxWidth: 140,
            maxHeight: 80,
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
              width: 280,
              height: 80,
            ),
          ),
        ),
      ],
    );
  }
}
