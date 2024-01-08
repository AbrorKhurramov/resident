import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class CardComponent extends StatefulWidget {
  final CardResponse? cardResponse;

  const CardComponent({this.cardResponse, Key? key}) : super(key: key);

  @override
  State<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: AppConfig.screenWidth(context),
        height: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          margin: EdgeInsets.zero,
          elevation: 24,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                gradient: widget.cardResponse == null ? AppColor.defaultCardGradient() : null),
            child: Stack(
              children: [
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset('assets/icons/card_background.svg',
                      color: widget.cardResponse == null ? AppColor.c80000 : AppColor.c6000),
                )),
                Positioned(
                    child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [const Spacer(), _initEmptyCard(), const Spacer(), _initCardInfo()],
                  ),
                )),
              ],
            ),
          ),
        ));
  }

  Widget _initEmptyCard() {
    return Image.asset('assets/images/card_chip.png');
  }

  Widget _initCardInfo() {
    return widget.cardResponse != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cardResponse?.cardHolder ?? '',
                style: Theme.of(context).textTheme.headline4!.copyWith(color: AppColor.c4000, fontSize: 16),
              ),
              AppDimension.verticalSize_8,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cardResponse?.cardNumber?.cardNumberFormat() ?? '',
                    style: Theme.of(context).textTheme.headline4!.copyWith(color: AppColor.c3000, fontSize: 14),
                  ),
                  const Spacer(),
                  Text(
                    widget.cardResponse?.expiryDate?.cardExpiryFormat() ?? '',
                    style: Theme.of(context).textTheme.headline4!.copyWith(color: AppColor.c3000, fontSize: 14),
                  ),
                  const Spacer(),
                ],
              )
            ],
          )
        : const SizedBox();
  }
}
