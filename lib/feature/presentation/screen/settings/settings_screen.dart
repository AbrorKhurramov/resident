import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late StreamSubscription listener;

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }

  @override
  void initState() {
    super.initState();

    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          BlocProvider.of<NotInternetCubit>(context).changeState(true);
          break;
        case InternetConnectionStatus.disconnected:
          BlocProvider.of<NotInternetCubit>(context).changeState(false);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotInternetCubit, bool>(builder: (context, state) {
      return Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Settings screen',style: TextStyle(fontSize: 14.sf(context))),
        ),
      );
    }, listener: (context, state) {
      print(state);
      if (!state) {
      //  Navigator.of(context).pushNamed(AppRouteName.notInternetScreen);
      } else {
        //Navigator.pop(context);
      }
    });
  }
}
