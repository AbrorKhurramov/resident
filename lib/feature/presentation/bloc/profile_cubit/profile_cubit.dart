import 'package:either_dart/either.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/domain/use_case/service_use_case/get_services_list_use_case.dart';
import 'package:resident/feature/presentation/bloc/profile_cubit/profile_state.dart';

import '../../../domain/use_case/notification_use_case/notifications_count_use_case.dart';

class ProfileCubit extends RepositoryCubit<ProfileState> {
  late final GetProfileUseCase _getProfileUseCase;
  late final GetNotificationUseCase _getNotificationUseCase;
  late final InsertUserUseCase _insertUserUseCase;
  late final UpdateProfileUseCase _updateProfileUseCase;
  late final NotificationsCountUseCase _notificationsCountUseCase;
  late final GetServicesListUseCase _getServicesListUseCase;

  User? user;
  BaseResponse<void>? response;

  ProfileCubit({
    required GetProfileUseCase getProfileUseCase,
    required GetNotificationUseCase getNotificationUseCase,
    required InsertUserUseCase insertUserUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required NotificationsCountUseCase notificationsCountUseCase,
    required GetServicesListUseCase getServicesListUseCase,
  }) : super(const ProfileState(stateStatus: StateStatus.initial,firebaseNotificationState: true)) {
    _getProfileUseCase = getProfileUseCase;
    _insertUserUseCase = insertUserUseCase;
    _getNotificationUseCase = getNotificationUseCase;
    _getServicesListUseCase = getServicesListUseCase;
    _updateProfileUseCase = updateProfileUseCase;
    _notificationsCountUseCase = notificationsCountUseCase;
  }


  Future<void> getProfile() async {

    emit(state.copyWith(stateStatus: StateStatus.loading));
    await _getProfileUseCase.call(NoParams(cancelToken: cancelToken)).thenRight(
        (user) {

      this.user = user;

          return _insertUserUseCase.call(InsertUserUseCaseParams(user));
    }).fold(
        (left) {
          emit(
            state.copyWith(stateStatus: StateStatus.failure, failure: left));
        },
        (right) =>
            emit(state.copyWith(stateStatus: StateStatus.success, user: user)));
  }

  Future<void> getFirebaseNotificationState() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final firebaseToken = await firebaseMessaging.getToken();
    emit(state.copyWith(stateStatus: StateStatus.loading));
    await _getNotificationUseCase
        .call(GetNotificationUseCaseParams(
      firebaseToken.toString(), cancelToken))
        .fold(
            (left) {
              print('LEFT Here');
              emit(state.copyWith(
              stateStatus: StateStatus.failure,failure: left));
        },
            (right) {
              print('RIGHT Here');
          emit(state.copyWith(
            stateStatus: StateStatus.success,
            firebaseNotificationState: right,
          ));}
    );
  }

  Future<void> getNotificationsCount(String apartmentId) async {

    emit(state.copyWith(stateStatus: StateStatus.loading));
     _notificationsCountUseCase
        .call(NotificationsCountUseCaseParams(
        apartmentId, cancelToken))
        .fold(
          (left) {
            print("LEFT notificationCount");
            print(left.toString());

            if(left is CancelFailure) return;
            emit(state.copyWith(
            stateStatus: StateStatus.failure,failure: left));
      },
          (right) {
            emit(state.copyWith(
          stateStatus: StateStatus.success,
          notificationsCount: right.data,
          ));}
    );
  }

  Future<void> getServicesList() async {

    emit(state.copyWith(stateStatus: StateStatus.loading));
     _getServicesListUseCase
        .call(GetServicesListUseCaseParams(
        FilterRequestParam(page: 0,size: 10,sortBy: "id",sortDir: "asc"), cancelToken))
        .fold(
          (left) {
            print("LEFT serviceList");
            print(left.toString());

            if(left is CancelFailure) return;
            emit(state.copyWith(
            stateStatus: StateStatus.failure,failure: left));
      },
          (right) {
            debugPrint("SERVICE DATA");
            debugPrint(right.data.toString());
            emit(state.copyWith(
          stateStatus: StateStatus.success,
          servicesList: right.data,
          ));}
    );
  }



  Future<void> updateProfile(String firstName, String lastName,
      String phoneNumber, String? photoId) async {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    _updateProfileUseCase
        .call(UpdateProfileUseCaseParams(
            UserUpdateRequest(
                firstName: firstName,
                lastName: lastName,
                phoneNumber: phoneNumber,
                photoId: photoId),
            cancelToken))
        .thenRight((right) {
          response = right;
          return _getProfileUseCase.call(NoParams(cancelToken: cancelToken));
        })
        .fold(
            (left) => emit(state.copyWith(
                stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(
                state.copyWith(stateStatus: StateStatus.success, response: response, user: right)));
  }
}
