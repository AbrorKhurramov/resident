
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/core/extension/size_extension.dart';

class SuccessfulBottomSheet extends StatefulWidget {
  final String description;
  final BuildContext subContext;
 final int isAdd;
  const SuccessfulBottomSheet({Key? key, required this.description,required this.isAdd,required this.subContext})
      : super(key: key);

  @override
  State<SuccessfulBottomSheet> createState() => _SuccessfulBottomSheetState();
}

class _SuccessfulBottomSheetState extends State<SuccessfulBottomSheet> {
  late AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async {
        if(widget.isAdd==1) {
          widget.subContext.read<CardCubit>().getCardList();
        }
          Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            width: AppConfig.screenWidth(context),
            height: AppConfig.screenHeight(context) * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                            'assets/icons/modal_bottom_top_line.svg'),
                        const SizedBox(height: 64),
                        SizedBox(
                          width: 96,
                          height: 96,
                          child: SvgPicture.asset('assets/icons/success.svg'),
                        ),
                        AppDimension.verticalSize_24,
                        Text(
                          widget.description.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: AppColor.c4000, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 32,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.c6000, disabledForegroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.38), disabledBackgroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.12)),
                          onPressed: () {
                            if(widget.isAdd==1) {
                              widget.subContext.read<CardCubit>().getCardList();
                            }
                            Navigator.pop(context, true);
                          },
                          child: Text(_appLocalization.go_back.capitalize(),style: TextStyle(fontSize: 14.sf(context)))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
