import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'dart:developer' as developer;

import 'package:resident/feature/presentation/app_route/app_route_name.dart';

import 'package:resident/feature/presentation/component/app_text_field.dart';
import 'package:resident/feature/presentation/screen/login/component/language_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/screen/login/component/support_bottom_sheet.dart';
import 'package:resident/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/extension/my_new_version.dart';
import '../../bloc/splash_cubit/splash_cubit.dart';
import '../../bloc/splash_cubit/splash_state.dart';
import '../../component/app_modal_bottom_sheet.dart';
import '../not_internet/not_internet_screen.dart';

class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => getIt<LoginCubit>(),
        child: const LoginScreen(),
      );
    });
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {


  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isNetwork = false;




  late AppLocalizations _appLocalization;
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _loginFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //TODO App Store va Play Market ga chqarish kerak
   // context.read<SplashCubit>().forceUpdate();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    final newVersion = NewVersion(
      iOSId: 'uz.maroqand.resident',
      androidId: 'uz.maroqand.resident',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = true;

    if (simpleBehavior) {
      basicStatusCheck(newVersion);
    } else {
      advancedStatusCheck(newVersion);
    }
  }

  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    print("status");
    print(status);
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Update Available',
        dialogText: 'Custom Text',
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initConnectivity();
   _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
    _loginController.dispose();
    _passwordController.dispose();
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
      child: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
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
            ),
            child: SafeArea(
              child: Column(
                children: [
                  AppDimension.verticalSize_24,
                  _initAppBarWithLanguage(),
                  const SizedBox(height: 64),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppTextField(
                          textFormField: TextFormField(
                            controller: _loginController,
                            focusNode: _loginFocusNode,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(_passwordFocusNode);
                            },
                            maxLength: 16,
                            textInputAction: TextInputAction.next,
                            onChanged: _onChangedLogin,
                            style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 17.sf(context), color: Colors.white),
                            decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                hintText: _appLocalization.login_hint_label.capitalize(),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(fontSize: 17.sf(context), color: Colors.white.withOpacity(0.3))),
                          ),
                          focusNode: _loginFocusNode,
                          borderColor: Colors.white.withOpacity(0.5),
                          label: _appLocalization.login.toUpperCase(),
                          hintLabel: _appLocalization.login_hint_label.capitalize(),
                          labelColor: Colors.white,
                        ),
                      );
                    },
                  ),
                  AppDimension.verticalSize_24,
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppTextField(
                          textFormField: TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            maxLength: 32,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            onChanged: _onChangedPassword,
                            style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 17.sf(context), color: Colors.white),
                            decoration: InputDecoration(
                                isDense: true,
                                counterText: "",
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                hintText: _appLocalization.password_hint_label.capitalize(),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(fontSize: 17.sf(context), color: Colors.white.withOpacity(0.3))),
                          ),
                          focusNode: _passwordFocusNode,
                          borderColor: Colors.white.withOpacity(0.5),
                          label: _appLocalization.password.toUpperCase(),
                          hintLabel: _appLocalization.password_hint_label.capitalize(),
                          labelColor: Colors.white,
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) async{
                      if (state.stateStatus == StateStatus.success) {
                        if(state.user!.apartments.isEmpty){
                          MyApp.logOut(context);
                         showErrorFlushBar(context, "Apartments are empty!");
                        }
else if(state.user!.firstEnter==false) {
                          context.read<AppCubit>().logIn(state.user!,false);
                          var a = await getBoolValuesSF();
                          if(a==true) {
                            Navigator.of(context).pushReplacementNamed(AppRouteName.changePhoneScreen);
                          }
                          else {
                            Navigator.of(context).pushReplacementNamed(AppRouteName.changePasswordScreen,
                                arguments: state.password);
                          }

                        } else {
                          context.read<AppCubit>().logIn(state.user!,true);
                          Navigator.of(context).pushReplacementNamed(AppRouteName.pinCodeScreen);
                        }
                      } else if (state.stateStatus == StateStatus.failure) {
                        MyApp.failureHandling(context, state.failure!);
                      }
                    },
                    builder: (context, state) {
                      return BlocBuilder<NotInternetCubit, bool>(
                        builder: (context, internetState) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 36),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(onSurface: Colors.white.withOpacity(0.15)),
                                onPressed: _validate(state.login, state.password) && internetState ? _login : null,
                                child: state.stateStatus == StateStatus.loading
                                    ? const CupertinoActivityIndicator(radius: 12)
                                    : Text(_appLocalization.to_come.toUpperCase(),style: TextStyle(fontSize: 14.sf(context)))),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )),
      ),
    )),
);
  }


  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool('boolValue');
    return boolValue;
  }
  bool _validate(String login, String password) {
    if (login.length >= 3 && password.length >= 3) {
      return true;
    }
    return false;
  }

  _login() {
    context.read<LoginCubit>().login();
  }

  _onChangedLogin(String changedText) {
    context.read<LoginCubit>().onChangeLogin(changedText);
  }

  _onChangedPassword(String changedText) {
    context.read<LoginCubit>().onChangePassword(changedText);
  }

  _initAppBarWithLanguage() {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 20,
              child: InkWell(
                onTap: _onPressedSupport,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white)),
                  child: Center(
                    child: SvgPicture.asset('assets/icons/support.svg'),
                  ),
                ),
              )),
          Positioned(
              top: 90,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 280,
                height: 80,
              )),
          const Positioned(top: 0, right: 0, child: LanguageComponent())
        ],
      ),
    );
  }

  _onPressedSupport() {
    showAppModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider(
              create: (_) => getIt<SupportCubit>(),
              child: SupportBottomSheet(isLogin: false));
        });
  }
}
