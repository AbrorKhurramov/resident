import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';

class NotificationComponent extends StatefulWidget {
  final String label;
  const NotificationComponent({Key? key, required this.label,
  }) : super(key: key);

  @override
  State<NotificationComponent> createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {


  void _onPressedNotification(bool notification) async{

    if (notification) {
     await context.read<NotificationCubit>().turnOnNotification();
    } else {
     await context.read<NotificationCubit>().turnOffNotification();
    }
    await context.read<ProfileCubit>().getFirebaseNotificationState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      return ElevatedButton(
        onPressed: () {
          _onPressedNotification(!state.firebaseNotificationState);
          },
        style: ElevatedButton.styleFrom(
            fixedSize: Size(double.infinity, 64),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPrimary: Colors.blue,
            primary: Colors.white,
            elevation: 0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
               widget.label,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: AppColor.c4000, fontSize: 14.sf(context)),
              ),
              CupertinoSwitch(
                  value: state.firebaseNotificationState,
                  onChanged: (changed) {
                    _onPressedNotification(changed);
                  })
            ],
          ),
        ),
      );
    });
  }
}
