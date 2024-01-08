// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appeal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppealResponse _$AppealResponseFromJson(Map<String, dynamic> json) =>
    AppealResponse(
      id: json['id'] as String?,
      content: json['content'] as String?,
      imageFiles: (json['fileMinList'] as List<dynamic>)
          .map((e) => ImageFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['regStatus'] as int,
      appealType: AppealType.fromJson(json['type'] as Map<String, dynamic>),
      regApplicationReply: json['regApplicationReply'],
      createdDate: json['createdDate'] as String,
    );

Map<String, dynamic> _$AppealResponseToJson(AppealResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'fileMinList': instance.imageFiles,
      'regStatus': instance.status,
      'type': instance.appealType,
      'regApplicationReply': instance.regApplicationReply,
      'createdDate': instance.createdDate,
    };
