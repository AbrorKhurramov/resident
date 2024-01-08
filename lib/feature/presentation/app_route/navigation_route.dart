import 'package:flutter/material.dart';

class NavigationRoute {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? replaceNavigateTo(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic>? clearNavigateTo(String routeName) {
    return navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  Future<dynamic>? clearNavigateUntilTo(String routeName) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (route) => route.isFirst);
  }

  Future<dynamic>? clearNavigateAll(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  Future<dynamic>? navigateTo(String routeName, {dynamic arguments}) async {
    return await navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  goBack({dynamic result}) {
    return navigatorKey.currentState!.pop(result);
  }

  void showError(message) {
  //   navigatorKey.currentContext?.showFlashBar(
  //     barType: FlashBarType.error,
  //     content: Text(
  //       message,
  //       style: AppTextStyle.appBarTitle.copyWith(
  //         fontWeight: FontWeight.w500,
  //         color: AppColor.assets,
  //       ),
  //     ),
  //     actionColor: AppColor.transparent,
  //     icon: const Icon(Icons.error_outline),
  //     duration: AppDuration.duration3,
  //     backgroundColor: AppColor.secondary,
  //   );
  }
}
