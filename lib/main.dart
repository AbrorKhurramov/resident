import 'package:firebase_core/firebase_core.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/presentation/screen/pin_code/enum/pin_code_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app_package/presentation/bloc_package.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/util/dialog/compulsory_update_dialog.dart';
import 'feature/presentation/app_route/app_route_name.dart';
import 'feature/presentation/app_route/app_router.dart';
import 'feature/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'injection/injection_container.dart' as di;
import 'dart:ui' as ui;


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var sysLng = ui.window.locale.languageCode;
  await di.init(sysLng);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();


  static _openLoginScreen(BuildContext _,
      {PinCodeStatus? pinCodeStatus}) async {
    Navigator.pushNamedAndRemoveUntil(
        _, AppRouteName.loginScreen, (route) => false,
        arguments: pinCodeStatus);
  }

  static logOut(BuildContext _) async {
    _openLoginScreen(_, pinCodeStatus: PinCodeStatus.enter);
    await Future.delayed(const Duration(seconds: 1));
    navigatorKey.currentContext!.read<AppCubit>().logOut();
  }

  static tokenExpiryLogOut(BuildContext _) async {
    _openLoginScreen(_);
    await Future.delayed(const Duration(seconds: 1));
    navigatorKey.currentContext!.read<AppCubit>().updateUser(
        isAuthorization: false);
  }

  static failureHandling(BuildContext _, Failure failure) async {
    AppLocalizations appLocalization = AppLocalizations.of(_)!;
    String errorMessage;

    if (failure is CancelFailure) {
      return;
    }
    else if (failure is TokenExpiryFailure) {
      print("TOKEN Expiry");
      tokenExpiryLogOut(_);
      errorMessage = appLocalization.login_error_message;
      //return;
    }
    else if (failure is ServerFailure) {
      if (failure.message != null) {
        errorMessage = failure.message!.translate(_
            .read<LanguageCubit>()
            .state
            .languageCode) ?? '';
      } else {
        errorMessage = appLocalization.error_message_not_found;
      }
    }
    else if (failure is ConnectionTimeOutFailure) {
      errorMessage = appLocalization.server_error_message;
    }
    else if (failure is JsonCastFailure) {
      errorMessage = appLocalization.json_cast_failure_error_message;
    }
    else {
      errorMessage = appLocalization.internet_failure_message;
    }
    showErrorFlushBar(_, errorMessage);
  }
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.getIt<NotInternetCubit>()),
        BlocProvider(create: (_) => di.getIt<LanguageCubit>()),
        BlocProvider(create: (_) => di.getIt<AppCubit>()),
        BlocProvider(create: (_) => di.getIt<ProfileCubit>()),
        BlocProvider(create: (_) => di.getIt<SplashCubit>()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, appState) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Resident',
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                locale: Locale(languageState.languageCode),
                theme: ThemeData(
                  fontFamily: 'Montserrat',
                  textTheme: const TextTheme(
                      bodySmall: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w900,
                      ),
                      displayLarge: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                      ),
                      displayMedium: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                      displaySmall: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                      headlineMedium: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                      headlineSmall: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w300,
                      ),
                      labelLarge: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      )),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(48),
                        ),
                      ),
                      disabledForegroundColor: Colors.white.withOpacity(0.3).withOpacity(0.38), disabledBackgroundColor: Colors.white.withOpacity(0.3).withOpacity(0.12),
                      fixedSize: const Size(double.maxFinite, 56),
                    ),
                  ),
                  primarySwatch: Colors.blue,
                ),
                initialRoute: _initialRoute(context.read<AppCubit>().state.isAuthorization),
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }

  String _initialRoute(bool isAuthorization) {
    if (isAuthorization) {
      return AppRouteName.pinCodeScreen;
    }
    return AppRouteName.loginScreen;
  }

}


Future<bool?> showCompulsoryUpdateDialog(BuildContext context) async {
  return await showGeneralDialog(
    context: context,
    pageBuilder: (_, __, ___) => const SizedBox(),
    transitionBuilder: (context, a1, a2, widget) {
      final curvedValue = Curves.easeOut.transform(a1.value) - 1.0;
      return Transform(
        transform: Matrix4.translationValues(0, curvedValue * 200, 0),
        child: Opacity(
          opacity: a1.value,
          child: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const CompulsoryUpdateDialog(),
          ),
        ),
      );
    },
    barrierDismissible: false,
    barrierLabel: '',
    transitionDuration: const Duration(milliseconds: 400),
    barrierColor: const Color(0xff000000).withOpacity(.5),
  );
}
