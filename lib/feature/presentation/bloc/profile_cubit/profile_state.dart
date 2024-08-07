import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class ProfileState extends Equatable {
  final StateStatus stateStatus;
  final User? user;
  final bool firebaseNotificationState;
  final BaseResponse<void>? response;
  final List<MerchantResponse>? servicesList;
  final  NotificationsCount? notificationsCount;
  final Failure? failure;

  const ProfileState(
      {required this.stateStatus, this.user,required this.firebaseNotificationState,this.servicesList, this.response,this.notificationsCount, this.failure});

  ProfileState copyWith(
      {StateStatus? stateStatus,
      User? user,
        bool? firebaseNotificationState,
         NotificationsCount? notificationsCount,
        List<MerchantResponse>? servicesList,
      BaseResponse<void>? response,
      Failure? failure}) {
    return ProfileState(
        stateStatus: stateStatus ?? this.stateStatus,
        user: user ?? this.user,
        servicesList: servicesList??this.servicesList,
        notificationsCount: notificationsCount??this.notificationsCount,
        firebaseNotificationState: firebaseNotificationState??this.firebaseNotificationState,
        response: response ?? this.response,
        failure: failure);
  }

  @override
  List<Object?> get props => [stateStatus,servicesList, user, response, failure,firebaseNotificationState,notificationsCount];
}
