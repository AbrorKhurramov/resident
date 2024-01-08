import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/component/app_arrow_card.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:resident/feature/presentation/screen/appeal/component/appeal_list_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

import '../../../domain/entity/response/appeal_type.dart';

class OtherCategoryScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => getIt<AppealCubit>(),
        child: const OtherCategoryScreen(),
      );
    });
  }

  const OtherCategoryScreen({Key? key}) : super(key: key);

  @override
  State<OtherCategoryScreen> createState() => _OtherCategoryScreenState();
}

class _OtherCategoryScreenState extends State<OtherCategoryScreen> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/part_third_gradient.png',
              ),
              fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(label: "Выберите категорию",voidCallback:  () {
                Navigator.of(context).pop();
              },),

            ],
          ),
        ),
      ),
    );
  }

  void _openScreen(String routeName, List<AppealType>? appealTypes) {
    Navigator.pushNamed(context, routeName,arguments: appealTypes);
  }
}
