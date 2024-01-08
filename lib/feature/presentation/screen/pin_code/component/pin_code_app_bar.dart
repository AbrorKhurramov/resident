import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

class PinCodeAppBar extends StatelessWidget {
  const PinCodeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations _appLocalization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  fixedSize: const Size(32, 32),
                  primary: Colors.white,
                  onPrimary: Theme.of(context).primaryColor, // <-- Splash color
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/icons/left_app_bar.svg'),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: BlocBuilder<PinCodeCubit, PinCodeState>(
                builder: (context, state) {
                  return Text(
                    _appLocalization.set_up_pin_code.capitalize(),
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
