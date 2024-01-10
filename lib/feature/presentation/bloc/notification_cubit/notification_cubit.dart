import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/feature/domain/entity/request/firebase_notification_update_request.dart';
import 'package:resident/injection/params/notification_param.dart';

import '../../../../core/bloc/repository_cubit.dart';

class NotificationCubit extends RepositoryCubit<bool> {
  final SetUpNotificationUseCase setUpNotificationUseCase;

  NotificationCubit(
      {required this.setUpNotificationUseCase,
      required bool initialState})
      : super(initialState);




  Future<void> turnOnNotification() async{
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final firebaseToken = await firebaseMessaging.getToken();
    print("SUBSCRIBE");
    firebaseMessaging.subscribeToTopic('news');
   await setUpNotificationUseCase
        .call(SetUpNotificationParams(
      FirebaseNotificationUpdateRequest(
        firebaseToken: firebaseToken,
        notification: true
      ),
      cancelToken
    ))
        .fold((left) => null, (right) {
      getIt.unregister<NotificationParam>();
      getIt.registerFactory<NotificationParam>(
          () => NotificationParam(notification: true));
      emit(true);
    });
  }

  Future<void> turnOffNotification() async{
    print("off");
    print("UNSUBSCRIBE");
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final firebaseToken = await firebaseMessaging.getToken();
    firebaseMessaging.unsubscribeFromTopic('news');
   await setUpNotificationUseCase
        .call(SetUpNotificationParams(
        FirebaseNotificationUpdateRequest(
            firebaseToken: firebaseToken,
            notification: false
        ),
        cancelToken
    ))
        .fold((left) => null, (right) {
      getIt.unregister<NotificationParam>();
      getIt.registerFactory<NotificationParam>(
          () => NotificationParam(notification: false));
      emit(false);
    });
  }
}
