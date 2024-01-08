// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_notification_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseNotificationUpdateRequest _$FirebaseNotificationUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    FirebaseNotificationUpdateRequest(
      notification: json['notification'] as bool?,
      firebaseToken: json['fire_base_token'] as String?,
    );

Map<String, dynamic> _$FirebaseNotificationUpdateRequestToJson(
        FirebaseNotificationUpdateRequest instance) =>
    <String, dynamic>{
      'notification': instance.notification,
      'fire_base_token': instance.firebaseToken,
    };
