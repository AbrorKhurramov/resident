// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reg_application_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegApplicationReply _$RegApplicationReplyFromJson(Map<String, dynamic> json) =>
    RegApplicationReply(
      id: json['id'] as String,
      content: json['content'] as String,
      contentFiles: (json['contentFiles'] as List<dynamic>?)
          ?.map((e) => ImageFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdDate: json['created_date'] as String,
    );

Map<String, dynamic> _$RegApplicationReplyToJson(
        RegApplicationReply instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'contentFiles': instance.contentFiles,
      'created_date': instance.createdDate,
    };
