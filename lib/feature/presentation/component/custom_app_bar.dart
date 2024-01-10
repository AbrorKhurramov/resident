import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class CustomAppBar extends StatelessWidget {
  final String label;
  final VoidCallback? voidCallback;

  const CustomAppBar({Key? key, required this.label, this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: voidCallback ??
                    () {
                      Navigator.of(context).pop();
                    },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor, shape: const CircleBorder(), backgroundColor: Colors.white,
                  fixedSize: const Size(32, 32),
                  elevation: 0, // <-- Splash color
                ),
                child: Center(
                  child: SvgPicture.asset('assets/icons/left_app_bar.svg'),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
