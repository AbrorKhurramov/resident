import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class AppEmptyCard extends StatelessWidget {
  final String path;
  final String description;

  const AppEmptyCard({Key? key, required this.path, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 8,
      shadowColor: Colors.white.withOpacity(0.7),
      color: Colors.white.withOpacity(0.7),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            children: [
              Container(
                width: 104,
                height: 104,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: SvgPicture.asset(path),
                ),
              ),
              AppDimension.verticalSize_24,
              Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 15.sf(context), color: AppColor.c3000),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
