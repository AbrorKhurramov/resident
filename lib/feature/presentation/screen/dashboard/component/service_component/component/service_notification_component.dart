import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';

class ServiceNotificationComponent extends StatefulWidget {
  const ServiceNotificationComponent({Key? key}) : super(key: key);

  @override
  State<ServiceNotificationComponent> createState() => _ServiceNotificationComponentState();
}

class _ServiceNotificationComponentState extends State<ServiceNotificationComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      width: AppConfig.screenWidth(context),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: AppColor.c6000,
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/bell.svg'),
          AppDimension.horizontalSize_24,
          Expanded(
            child: Text(
              'Через 3 дня будет не забудьте оплатить 100 000 сум за кварплату',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
