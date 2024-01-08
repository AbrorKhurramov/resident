// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appeal_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppealRequest _$AppealRequestFromJson(Map<String, dynamic> json) =>
    AppealRequest(
      apartmentId: json['apartment_id'] as String,
      content: json['content'] as String,
      imageFileId:
          (json['file_ids'] as List<dynamic>).map((e) => e as String).toList(),
      type: json['type'] as int,
    );

Map<String, dynamic> _$AppealRequestToJson(AppealRequest instance) =>
    <String, dynamic>{
      'apartment_id': instance.apartmentId,
      'content': instance.content,
      'file_ids': instance.imageFileId,
      'type': instance.type,
    };
