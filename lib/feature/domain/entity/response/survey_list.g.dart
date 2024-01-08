// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyList _$SurveyListFromJson(Map<String, dynamic> json) => SurveyList(
      id: json['id'] as String,
      name: Message.fromJson(json['name'] as Map<String, dynamic>),
      type: json['type'] as int,
      expiryDate: json['expiryDate'] as String,
      description:
          Message.fromJson(json['description'] as Map<String, dynamic>),
      isExpired: json['isExpired'] as bool,
      isAnswered: json['isAnswered'] as bool,
    );

Map<String, dynamic> _$SurveyListToJson(SurveyList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'expiryDate': instance.expiryDate,
      'description': instance.description,
      'isExpired': instance.isExpired,
      'isAnswered': instance.isAnswered,
    };
