import 'package:flutter/material.dart';

class AppConfig {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double bottomBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static double toolbarHeight(BuildContext context) {
    return kToolbarHeight;
  }
}
