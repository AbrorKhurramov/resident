// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: json['id'] as String,
      status: json['status'] as bool,
      question: Message.fromJson(json['question'] as Map<String, dynamic>),
      type: json['type'] as int,
      note: json['note'] as String,
      description:
          Message.fromJson(json['description'] as Map<String, dynamic>),
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => Variant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'question': instance.question,
      'type': instance.type,
      'note': instance.note,
      'description': instance.description,
      'variants': instance.variants,
    };
