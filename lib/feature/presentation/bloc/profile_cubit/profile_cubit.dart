import 'package:either_dart/either.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/profile_cubit/profile_state.dart';

import '../../../domain/use_case/notification_use_case/notifications_count_use_case.dart';

class ProfileCubit extends RepositoryCubit<ProfileState> {
  late final GetProfileUseCase _getProfileUseCase;
  late final GetNotificationUseCase _getNotificationUseCase;
  late final InsertUserUseCase _insertUserUseCase;
  late final UpdateProfileUseCase _updateProfileUseCase;
  late final NotificationsCountUseCase _notificationsCountUseCase;

  User? user;
  BaseResponse<void>? response;

  ProfileCubit({
    required GetProfileUseCase getProfileUseCase,
    required GetNotificationUseCase getNotificationUseCase,
    required InsertUserUseCase insertUserUseCase,
    required UpdateProfileUseCase updateProfileUseCase,
    required NotificationsCountUseCase notificationsCountUseCase,
  }) : super(const ProfileState(stateStatus: StateStatus.initial,firebaseNotificationState: true)) {
    _getProfileUseCase = getProfileUseCase;
    _insertUserUseCase = insertUserUseCase;
    _getNotificationUseCase = getNotificationUseCase;
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
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final firebaseToken = await _firebaseMessaging.getToken();
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
