// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newness.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Newness _$NewnessFromJson(Map<String, dynamic> json) => Newness(
      id: json['id'] as String?,
      name: json['name'] == null
          ? null
          : Message.fromJson(json['name'] as Map<String, dynamic>),
      content: json['content'] == null
          ? null
          : Message.fromJson(json['content'] as Map<String, dynamic>),
      createdDate: json['createdDate'] as String?,
      subContent: json['subContent'] == null
          ? null
          : Message.fromJson(json['subContent'] as Map<String, dynamic>),
      imageFile: json['logo'] == null
          ? null
          : ImageFile.fromJson(json['logo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewnessToJson(Newness instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'subContent': instance.subContent,
      'createdDate': instance.createdDate,
      'logo': instance.imageFile,
    };
