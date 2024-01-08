import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';

class AppFailure extends StatelessWidget {
  final Failure failure;

  const AppFailure({Key? key, required this.failure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String message;

    if (failure is TokenExpiryFailure) {
      message = 'error';
    } else if (failure is ServerFailure) {
      message = 'error';
    } else if (failure is ConnectionTimeOutFailure) {
      message = 'error';
    } else if (failure is JsonCastFailure) {
      message = 'error';
    } else if (failure is NetworkFailure) {
      message = 'error';
    } else if (failure is DatabaseFailure) {
      message = 'error';
    } else {
      message = (failure is ExceptionFailure).toString();
    }

    return Center(
      child: Text(message),
    );
  }
}
