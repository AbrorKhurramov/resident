import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/domain/use_case/auth_use_case/force_update_use_case.dart';
import 'package:resident/feature/presentation/bloc/splash_cubit/splash_state.dart';

import '../../../../injection/injection_container.dart';
import '../../../../main.dart';
import '../../app_route/app_route_name.dart';
import '../../bloc/splash_cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) =>
            SplashCubit(
              forceUpdateUseCase: getIt<ForceUpdateUseCase>(),
            ),

        child: SplashScreen(),);
    });
  }


  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("START TIME");
    print(DateTime.now().second);
 //   context.read<SplashCubit>().forceUpdate();
  }


  @override
  void initState() {
    super.initState();
  }

  String _initialRoute(bool isAuthorization) {
    if (isAuthorization) {
      return AppRouteName.pinCodeScreen;
    }
    return AppRouteName.loginScreen;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if(state.stateStatus == StateStatus.success){
            print("END TIME");
            print(DateTime.now().second);
            if(state.isForceUpdate){
              Navigator
                  .of(context)
                  .pushNamed(AppRouteName.forceUpdate);
            }
              else {
              Navigator
                  .pushReplacementNamed(context,_initialRoute(context.read<AppCubit>().state.isAuthorization));

            }
          }
          else if (state.stateStatus == StateStatus.failure) {
            MyApp.failureHandling(context, state.failure!);
          }
        },
        child: Container(
            width: AppConfig.screenWidth(context),
            height: AppConfig.screenHeight(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/splash_bg.png',
                  ),
                  fit: BoxFit.fill),
            )
        ),
      ),
    );
  }
}
