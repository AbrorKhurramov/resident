import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class CustomAppBar extends StatelessWidget {
  final String label;
  final VoidCallback? voidCallback;

  const CustomAppBar({Key? key, required this.label, this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
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
                child: Center(
                  child: SvgPicture.asset('assets/icons/left_app_bar.svg'),
                ),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  fixedSize: Size(32, 32),
                  primary: Colors.white,
                  elevation: 0,
                  onPrimary: Theme.of(context).primaryColor, // <-- Splash color
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
                    .headline2!
                    .copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
