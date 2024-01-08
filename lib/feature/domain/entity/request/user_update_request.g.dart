// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateRequest _$UserUpdateRequestFromJson(Map<String, dynamic> json) =>
    UserUpdateRequest(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      photoId: json['photo_id'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$UserUpdateRequestToJson(UserUpdateRequest instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'photo_id': instance.photoId,
      'phone_number': instance.phoneNumber,
    };
