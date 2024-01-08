import 'package:resident/core/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/presentation/bloc/pin_code/pin_code_cubit.dart';
import 'package:provider/src/provider.dart';

class PinCodeKeyboard extends StatefulWidget {
  PinCodeKeyboard({Key? key,required this.onTapBiometrics,required this.isVisible}) : super(key: key);
 void Function()  onTapBiometrics;
 bool isVisible;
  @override
  State<PinCodeKeyboard> createState() => _PinCodeKeyboardState();
}

class _PinCodeKeyboardState extends State<PinCodeKeyboard> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _initNumberButton('1'),
            AppDimension.horizontalSize_24,
            _initNumberButton('2'),
            AppDimension.horizontalSize_24,
            _initNumberButton('3'),
          ],
        ),
        AppDimension.verticalSize_8,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _initNumberButton('4'),
            AppDimension.horizontalSize_24,
            _initNumberButton('5'),
            AppDimension.horizontalSize_24,
            _initNumberButton('6'),
          ],
        ),
        AppDimension.verticalSize_8,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _initNumberButton('7'),
            AppDimension.horizontalSize_24,
            _initNumberButton('8'),
            AppDimension.horizontalSize_24,
            _initNumberButton('9'),
          ],
        ),
        AppDimension.verticalSize_8,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _initBiometricsButton(),
            AppDimension.horizontalSize_24,
            _initNumberButton('0'),
            AppDimension.horizontalSize_24,
            _initRemoveNumberButton(),
          ],
        )
      ],
    );
  }

  _initNumberButton(String number) {
    return ElevatedButton(
      onPressed: () {
        context.read<PinCodeCubit>().onKeyboardPressed(number);
      },
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        fixedSize: Size(72, 72),
        primary: Colors.white,
        onPrimary: Theme.of(context).primaryColor, // <-- Splash color
      ),
      child: Center(
        child: Text(
          number,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: AppColor.c4000, fontSize: 26.sf(context)),
        ),
      ),
    );
  }

  _initRemoveNumberButton() {
    return SizedBox(
        width: 64,
        height: 64,
        child: IconButton(
          onPressed: () {
            context.read<PinCodeCubit>().onRemovePressed();
          },
          icon: Icon(
            Icons.backspace_sharp,
            color: Colors.white,
          ),
        ));
  }
 _initBiometricsButton() {
    return SizedBox(
        width: 64,
        height: 64,
        child: Visibility(
          visible: widget.isVisible,
          child: IconButton(
            onPressed:widget.onTapBiometrics,
            icon: SvgPicture.asset("assets/icons/fingerprint.svg",width: 50,height: 50,color: Colors.white),
          ),
        ));
  }
}

