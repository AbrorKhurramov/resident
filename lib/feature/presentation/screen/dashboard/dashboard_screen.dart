import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'dart:developer' as developer;
import 'package:resident/feature/presentation/screen/dashboard/component/home_component/home_component.dart';
import 'package:resident/feature/presentation/screen/dashboard/component/profile_component/profile_component.dart';
import 'package:resident/feature/presentation/screen/dashboard/component/service_component/service_component.dart';
import 'package:resident/feature/presentation/screen/not_internet/not_internet_screen.dart';
import 'package:resident/injection/injection_container.dart';

import '../../../../main.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}
class DashboardScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(providers: [
        BlocProvider(create: (_) => getIt<DashboardCubit>()),
        BlocProvider(create: (_) => getIt<NewsCubit>()),
        BlocProvider(create: (_) => getIt<CounterCubit>()),
        BlocProvider(create: (_) => getIt<NotificationCubit>()),
      ], child: const DashboardScreen());
    });
  }
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isNetwork = false;

  PageController? _controller;

  @override
  void initState() {
    super.initState();
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //PushNotificationService().init();

    context.read<ProfileCubit>().getNotificationsCount(context.read<AppCubit>().getActiveApartment().id);
    context.read<ProfileCubit>().getProfile();
   // context.read<ProfileCubit>().getFirebaseNotificationState();

    _controller = PageController(
        initialPage: context.read<DashboardCubit>().state, keepPage: true);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
   initConnectivity();

  }

  @override
  void dispose() {
    super.dispose();
   _connectivitySubscription.cancel();
    _controller?.dispose();
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

  bool isEmpty(NotificationsCount value){
    if(value.regApplicationReplyCount!>0) return true;
    if(value.invoiceCount!>0) return true;
    if(value.serviceCount!>0) return true;
    if(value.surveyCount!>0) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotInternetCubit, bool>(listener: (context, state) {
    }, builder: (context, state) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            body: BlocBuilder<DashboardCubit, int>(
              builder: (context, dashState) {
                return BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, profileState) {
                    if (profileState.stateStatus == StateStatus.success && profileState.user!=null) {
                      context.read<AppCubit>().updateUser(user: profileState.user!);
                    }
                    else if (profileState.stateStatus == StateStatus.failure) {
                      print("fail");
                      MyApp.failureHandling(context, profileState.failure!);
                    }
                  },
  builder: (context, state) {
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, profileState) {
    return Stack(
                  children: [
                    Positioned(
                      top: AppConfig.statusBarHeight(context),
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: PageView(
                        onPageChanged: (int page) {
                          context.read<DashboardCubit>().changePage(page);
                          context.read<ProfileCubit>().getNotificationsCount(context.read<AppCubit>().getActiveApartment().id);
                        },
                        controller: _controller,
                        children: const [
                          ProfileComponent(),
                          HomeComponent(),
                          ServiceComponent()
                        ],
                      ),
                    ),
                    Positioned(
                      top: AppConfig.statusBarHeight(context),
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 56,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _initPageViewIconButton(
                                  0,
                                  dashState == 0
                                      ? 'assets/icons/active_profile.svg'
                                      : 'assets/icons/un_active_profile.svg',
                                  profileState.notificationsCount!=null? isEmpty(profileState.notificationsCount!):false
                              ),
                              _initPageViewIconButton(
                                  1,
                                  dashState == 1
                                      ? 'assets/icons/active_home.svg'
                                      : 'assets/icons/un_active_home.svg',profileState.notificationsCount!=null? isEmpty(profileState.notificationsCount!):false),
                              _initPageViewIconButton(
                                  2,
                                  dashState == 2
                                      ? 'assets/icons/active_service.svg'
                                      : 'assets/icons/un_active_service.svg',profileState.notificationsCount!=null? isEmpty(profileState.notificationsCount!):false),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
  },
);
  },
);
              },
            ),
          ));
    });
  }

  Widget _initPageViewIconButton(int page, String iconPath,bool isNotification) {
    return ElevatedButton(
      onPressed: () {
        _controller?.animateToPage(page,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor, shape: const CircleBorder(), backgroundColor: Colors.white,
        fixedSize: const Size(32, 32),
        elevation: 0, // <-- Splash color
      ),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          children: [

            Center(child: SvgPicture.asset(iconPath)),    Visibility(
              visible: page==2&&isNotification,
              child: Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red[500]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
