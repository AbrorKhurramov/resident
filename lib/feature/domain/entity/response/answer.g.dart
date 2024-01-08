// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      questionId: json['question_id'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'question_id': instance.questionId,
      'answers': instance.answers,
    };
