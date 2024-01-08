import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/app_cubit/app_state.dart';
import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection/injection_container.dart';
import '../../../../injection/params/notification_param.dart';
import '../../../domain/entity/request/firebase_notification_update_request.dart';

class AppCubit extends RepositoryCubit<AppState> {
  final InsertUserUseCase insertUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final DeleteTokenUseCase deleteTokenUseCase;
  final RemovePinCodeUseCase removePinCodeUseCase;
  final SetUpNotificationUseCase setUpNotificationUseCase;



  AppCubit({
    required this.insertUserUseCase,
    required this.deleteUserUseCase,
    required this.deleteTokenUseCase,
    required this.removePinCodeUseCase,
    required this.setUpNotificationUseCase,
    required AppState initialState,
  }) : super(initialState);

  void logIn(User user,bool isAuth) {
    turnOnNotification();
    emit(state.copyWith(isAuthorization: isAuth, user: user));
  }

  void logOut() async{
    turnOffNotification();
    deleteUserUseCase
        .call(const NoParams())
        .thenRight((right) => deleteTokenUseCase.call(const NoParams()))
        .thenRight((right) => removePinCodeUseCase.call(const NoParams()))
        .fold((left) => null, (right) async {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(isAuthorization: false, user: null));
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setBool('boolValue', false);

  }

  Future<void> turnOffNotification() async{
    debugPrint("off");
    debugPrint("UNSUBSCRIBE");
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final firebaseToken = await _firebaseMessaging.getToken();
    _firebaseMessaging.unsubscribeFromTopic('news');
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
    });
  }
  Future<void> turnOnNotification() async{
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final firebaseToken = await _firebaseMessaging.getToken();
    debugPrint("SUBSCRIBE");
    _firebaseMessaging.subscribeToTopic('news');
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
    });
  }



  void updateUser({User? user, bool? isAuthorization}) async {
    debugPrint("UPDATE USER$isAuthorization");
    if(isAuthorization==false){
       logOut();
    }
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(user:isAuthorization!=false?user:null, isAuthorization: isAuthorization));
  }




  void changeActiveApartment(int index) {
    List<Apartment> newList = [];
    for (int i = 0; i < state.user!.apartments.length; i++) {
      if (state.user!.apartments[i].id == state.user!.apartments[index].id) {
        Apartment apartment =
            state.user!.apartments[i].copyWith(selected: true);
        newList.add(apartment);
      } else {
        Apartment apartment =
            state.user!.apartments[i].copyWith(selected: false);
        newList.add(apartment);
      }
    }

    AppState appState =
        state.copyWith(user: state.user!.copyWith(apartments: newList));
    insertUserUseCase
        .call(InsertUserUseCaseParams(appState.user!))
        .fold((left) => null, (right) => emit(appState));
  }

  Apartment getActiveApartment() {
    debugPrint("ACTIVE APARTMENT");
    debugPrint(state.user!.getActiveApartment().id);
    return state.user!.getActiveApartment();
  }
}
