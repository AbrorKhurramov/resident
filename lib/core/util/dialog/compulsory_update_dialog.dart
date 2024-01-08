import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';

class CompulsoryUpdateDialog extends StatelessWidget {
  const CompulsoryUpdateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: const Text(
              "updateDialog",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: const Text(
             "Please Update",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed:() async{
                  var versionStatus = await NewVersion().getVersionStatus();
                  NewVersion().launchAppStore(versionStatus!.appStoreLink);
                },
                child: const Text(
                 "Update now",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),)
              ),
            ],
          )
        : AlertDialog(
            elevation: 2,
            backgroundColor: const Color(0xffFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
      title: const Text(
        "updateDialog",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          height: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: const Text(
        "Please Update",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          height: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: <Widget>[
              MaterialButton(
        onPressed:() async{
      var versionStatus = await NewVersion().getVersionStatus();
      NewVersion().launchAppStore(versionStatus!.appStoreLink);
    },
                child: const Text(
                  "Update now",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),)
              )
            ],
          );
  }
}
