import 'package:resident/core/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/log_out_bottom_sheet.dart';
import 'package:resident/feature/presentation/screen/pin_code/enum/pin_code_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/main.dart';

class PinForgotPassword extends StatefulWidget {
  const PinForgotPassword({Key? key}) : super(key: key);

  @override
  State<PinForgotPassword> createState() => _PinForgotPasswordState();
}

class _PinForgotPasswordState extends State<PinForgotPassword> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalization = AppLocalizations.of(context)!;

    return BlocBuilder<PinCodeCubit, PinCodeState>(
      builder: (context, state) {
        if (state.pinCodeStatus == PinCodeStatus.security) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(64)),
              onTap: _onPressedLogOut,
              splashColor: Theme.of(context).primaryColor,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(64)),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.5), width: 1)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/icons/exit.svg'),
                      AppDimension.horizontalSize_8,
                      Text(
                        appLocalization.exit.capitalize(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white, fontSize: 14.sf(context)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onPressedLogOut() {
    showAppModalBottomSheet(
        context: context,
        isExpand: false,
        builder: (context) {
          return const LogOutBottomSheet();
        }).then((value) {
      if (value != null && value) {
        MyApp.logOut(context);
      }
    });
  }
}
