// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      id: json['id'] as String?,
      message: json['name'] == null
          ? null
          : Message.fromJson(json['name'] as Map<String, dynamic>),
      content: json['content'] == null
          ? null
          : Message.fromJson(json['content'] as Map<String, dynamic>),
      imageFile: json['logo'] == null
          ? null
          : ImageFile.fromJson(json['logo'] as Map<String, dynamic>),
      createdDate: json['createdDate'] as String?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.message,
      'content': instance.content,
      'logo': instance.imageFile,
      'createdDate': instance.createdDate,
    };
