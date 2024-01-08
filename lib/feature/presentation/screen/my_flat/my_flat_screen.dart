import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_empty_card.dart';
import 'package:resident/feature/presentation/component/app_flat_card.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:resident/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyFlatScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
          create: (_) => getIt<MyFlatCubit>(), child: const MyFlatScreen());
    });
  }

  const MyFlatScreen({Key? key}) : super(key: key);

  @override
  State<MyFlatScreen> createState() => _MyFlatScreenState();
}

class _MyFlatScreenState extends State<MyFlatScreen> {
  int index = 0;

  late AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        width: AppConfig.screenWidth(context),
        height: AppConfig.screenHeight(context),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/part_first_gradient.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<MyFlatCubit, MyFlatState>(
            listener: (context, state) {
              if (state.stateStatus == StateStatus.success) {
                context.read<AppCubit>().changeActiveApartment(index);
                Navigator.of(context).pop();
                showSuccessFlushBar(
                    context,
                    state.response!.statusMessage.translate(
                        context.read<LanguageCubit>().state.languageCode)!);
              } else if (state.stateStatus == StateStatus.failure) {
                MyApp.failureHandling(context, state.failure!);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  CustomAppBar(
                      label: _appLocalization.my_apartments.capitalize()),
                  BlocBuilder<AppCubit, AppState>(builder: (context, state) {
                    if (state.user!.apartments.isNotEmpty) {
                      return RefreshIndicator(
                        onRefresh: () async{
                        },
                        child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  this.index = index;
                                  context
                                      .read<MyFlatCubit>()
                                      .changeActiveApartment(
                                          state.user!.apartments[index].id);
                                },
                                child: AppFlatCard(
                                    apartment: state.user!.apartments[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return AppDimension.verticalSize_24;
                            },
                            itemCount: state.user!.apartments.length),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppEmptyCard(
                        path: 'assets/icons/error_apartment_card.svg',
                        description:
                            _appLocalization.empty_apartment_description,
                      ),
                    );
                  })
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
