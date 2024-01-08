// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Survey _$SurveyFromJson(Map<String, dynamic> json) => Survey(
      id: json['id'] as String,
      name: Message.fromJson(json['name'] as Map<String, dynamic>),
      type: json['type'] as int,
      expiryDate: json['expiryDate'] as String,
      description:
          Message.fromJson(json['description'] as Map<String, dynamic>),
      isExpired: json['isExpired'] as bool,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => Answer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurveyToJson(Survey instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'expiryDate': instance.expiryDate,
      'description': instance.description,
      'isExpired': instance.isExpired,
      'questions': instance.questions,
      'results': instance.results,
      'answers': instance.answers,
    };
