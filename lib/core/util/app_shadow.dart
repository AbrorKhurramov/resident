import 'package:flutter/material.dart';

import 'app_color.dart';

class AppShadow {
  AppShadow._();




  static var cardShadow = [
    const BoxShadow(
      color: AppColor.shadowColor005,
      spreadRadius: 1,
      blurRadius: 10,
      offset:  Offset(1, 1),
    )
  ];


}
