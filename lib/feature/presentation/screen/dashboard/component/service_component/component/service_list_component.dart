import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';

class ServiceListComponent extends StatefulWidget {
  const ServiceListComponent({Key? key}) : super(key: key);

  @override
  State<ServiceListComponent> createState() => _ServiceListComponentState();
}

class _ServiceListComponentState extends State<ServiceListComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _initItem(index);
        },
        separatorBuilder: (context, index) {
          return AppDimension.verticalSize_24;
        },
        itemCount: 3);
  }

  Widget _initItem(int index) {
    late String label;
    late String iconPath;

    switch (index) {
      case 0:
        iconPath = 'assets/icons/gym.svg';
        label = 'Фитнес \nКлуб';
        break;
      case 1:
        iconPath = 'assets/icons/swim.svg';
        label = 'Летний \nБассейн';
        break;
      default:
        iconPath = 'assets/icons/baby.svg';
        label = 'Детский \nсад';
        break;
    }

    return Container(
      width: AppConfig.screenWidth(context),
      height: 148,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/splash_bg.png',
            ),
            fit: BoxFit.fill),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconPath),
          const Spacer(),
          Text(
            label,
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 24, color: Colors.white),
          )
        ],
      ),
    );
  }
}
