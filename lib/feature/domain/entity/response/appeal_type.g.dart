// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appeal_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppealType _$AppealTypeFromJson(Map<String, dynamic> json) => AppealType(
      id: json['id'] as int,
      name: Message.fromJson(json['name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppealTypeToJson(AppealType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
