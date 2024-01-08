// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsCount _$NotificationsCountFromJson(Map<String, dynamic> json) =>
    NotificationsCount(
      regApplicationReplyCount: json['regApplicationReplyCount'] as int?,
      surveyCount: json['surveyCount'] as int?,
      serviceCount: json['serviceCount'] as int?,
      invoiceCount: json['invoiceCount'] as int?,
    );

Map<String, dynamic> _$NotificationsCountToJson(NotificationsCount instance) =>
    <String, dynamic>{
      'regApplicationReplyCount': instance.regApplicationReplyCount,
      'surveyCount': instance.surveyCount,
      'serviceCount': instance.serviceCount,
      'invoiceCount': instance.invoiceCount,
    };
