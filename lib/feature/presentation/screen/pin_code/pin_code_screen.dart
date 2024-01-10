import 'package:resident/core/extension/size_extension.dart';
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/screen/pin_code/component/pin_code_app_bar.dart';
import 'package:resident/feature/presentation/screen/pin_code/component/pin_code_container.dart';
import 'package:resident/feature/presentation/screen/pin_code/component/pin_code_image.dart';
import 'package:resident/feature/presentation/screen/pin_code/component/pin_code_keyboard.dart';
import 'package:resident/feature/presentation/screen/pin_code/component/pin_forgot_password.dart';
import 'package:resident/feature/presentation/screen/pin_code/enum/pin_code_status.dart';
import 'package:resident/injection/injection_container.dart';
import 'dart:developer' as developer;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/injection/params/pin_code_param.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

import 'package:local_auth/local_auth.dart';

import '../../../../core/extension/my_new_version.dart';
import '../../../../injection/params/permission_param.dart';
import '../../../../main.dart';
import '../../bloc/splash_cubit/splash_cubit.dart';
import '../../bloc/splash_cubit/splash_state.dart';
import '../not_internet/not_internet_screen.dart';

class PinCodeScreen extends StatefulWidget {
  static Route<dynamic> route(PinCodeStatus? param) {
    PinCodeStatus pinCodeStatus;
    if (param != null) {
      pinCodeStatus = param;
    } else {
      getIt<PinCodeParam>().pinCode != null
          ? pinCodeStatus = PinCodeStatus.security
          : pinCodeStatus = PinCodeStatus.enter;
    }

    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => PinCodeCubit(
            setUpPinCodeUseCase: getIt<SetUpPinCodeUseCase>(),
            removePinCodeUseCase: getIt<RemovePinCodeUseCase>(),
            initialState: PinCodeState(pinCodeStatus: pinCodeStatus, activePinCode: getIt<PinCodeParam>().pinCode)),
        child: const PinCodeScreen(),
      );
    });
  }

  const PinCodeScreen({Key? key}) : super(key: key);

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isNetwork = false;



  late AppLocalizations _appLocalization;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
  //  context.read<SplashCubit>().forceUpdate();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    final newVersion = NewVersion(
      iOSId: 'uz.maroqand.resident',
      androidId: 'uz.maroqand.resident',
    );

    newVersion.showAlertIfNecessary(context: context);



  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initConnectivity();
    _appLocalization = AppLocalizations.of(context)!;
    _authenticateWithBiometrics();
  }

  Future<void> _authenticateWithBiometrics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if ((!availableBiometrics.contains(BiometricType.face)&&!availableBiometrics.contains(BiometricType.fingerprint))||!getIt<PermissionParam>().permission) {
      return;
    }

    if (context.read<PinCodeCubit>().state.pinCodeStatus != PinCodeStatus.security) {
      return;
    }

    bool authenticated = false;
    try {
      authenticated = await auth
          .authenticate(
        authMessages: [
          AndroidAuthMessages(
            signInTitle: _appLocalization.login_biometrics_required.capitalize(),
            cancelButton: _appLocalization.cancel.capitalize(),
            biometricHint: _appLocalization.verify_identity.capitalize()
          ),
          IOSAuthMessages(
            cancelButton: _appLocalization.cancel.capitalize(),
          ),
        ],
        localizedReason: _appLocalization.login_by_biometrics.capitalize(),
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      )
          .then((value) {
        if (value) {
          print("APPCUBIT");
          print(context.read<AppCubit>().state.user);
          dismissFlushBar();
          Navigator.pushReplacementNamed(context, AppRouteName.dashboardScreen);
        }
        return value;
      });
    } on PlatformException {
      return;
    }
    if (!mounted) {
      return;
    }
  }
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {

      _connectionStatus = result;
      print(_connectionStatus);

      if(_connectionStatus==ConnectivityResult.none) {
        if(!isNetwork) {
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) => NotInternetScreen(onTap: (){
            isNetwork = true;
            initConnectivity();

          })));
        }
      }
      else {
        if(isNetwork) {
          Navigator.pop(context);
          isNetwork = false;
        }
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
    auth.stopAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if(state.stateStatus == StateStatus.success){
          if(state.isForceUpdate){
            Navigator
                .of(context)
                .pushNamed(AppRouteName.forceUpdate);
          }
          else {
            print("AMAZING");
          }
        }
        else if (state.stateStatus == StateStatus.failure) {
          MyApp.failureHandling(context, state.failure!);
        }
      },
      child: Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<PinCodeCubit, PinCodeState>(
          builder: (context, state) {
            return Container(
                width: AppConfig.screenWidth(context),
                height: AppConfig.screenHeight(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      state.pinCodeStatus == PinCodeStatus.setup
                          ? 'assets/images/part_first_gradient.png'
                          : 'assets/images/splash_bg.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      BlocBuilder<PinCodeCubit, PinCodeState>(builder: (context, state) {
                        if (state.pinCodeStatus == PinCodeStatus.setup) {
                          return const PinCodeAppBar();
                        } else {
                          return const PinCodeImage();
                        }
                      }),
                      BlocBuilder<PinCodeCubit, PinCodeState>(builder: (context, state) {
                        if (state.pinCodeStatus == PinCodeStatus.setup) {
                          return const Spacer();
                        } else {
                          return AppDimension.verticalSize_32;
                        }
                      }),
                      BlocBuilder<PinCodeCubit, PinCodeState>(
                        builder: (context, state) {
                          switch (state.pinCodeStatus) {
                            case PinCodeStatus.setup:
                              String title;
                              if (!state.isCurrentPinCodeFilled) {
                                title = _appLocalization.enter_active_pin_code.capitalize();
                              } else if (!state.isNewPinCodeFilled) {
                                title = _appLocalization.enter_new_pin_code.capitalize();
                              } else {
                                title = _appLocalization.confirm_pin_code.capitalize();
                              }
                              return Text(
                                title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(color: AppColor.c4000, fontSize: 14.sf(context)),
                              );
                            case PinCodeStatus.enter:
                              return Text(
                                !state.isNewPinCodeFilled
                                    ? _appLocalization.come_up_pin_code.capitalize()
                                    : _appLocalization.confirm_pin_code.capitalize(),
                                style:
                                    Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white, fontSize: 14.sf(context)),
                              );
                            default:
                              return Text(
                                _appLocalization.enter_pin_code.capitalize(),
                                style:
                                    Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white, fontSize: 14.sf(context)),
                              );
                          }
                        },
                      ),
                      BlocBuilder<PinCodeCubit, PinCodeState>(builder: (context, state) {
                        if (state.pinCodeStatus == PinCodeStatus.setup) {
                          return AppDimension.verticalSize_64;
                        } else {
                          return AppDimension.verticalSize_32;
                        }
                      }),
                      const PinCodeContainer(),
                      AppDimension.verticalSize_24,
                      PinCodeKeyboard(
                          isVisible: state.pinCodeStatus == PinCodeStatus.security,
                          onTapBiometrics: () async{
                        print("WORK BIO");
                       await _authenticateWithBiometrics();
                      }),
                      const Spacer(),
                      const PinForgotPassword(),
                      AppDimension.verticalSize_12,
                    ],
                  ),
                ));
          },
        ),
      ),
    ),
);
  }
}
