// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variant _$VariantFromJson(Map<String, dynamic> json) => Variant(
      id: json['id'] as String,
      name: Message.fromJson(json['name'] as Map<String, dynamic>),
      note: json['note'] as String,
      description:
          Message.fromJson(json['description'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VariantToJson(Variant instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'note': instance.note,
      'description': instance.description,
    };
