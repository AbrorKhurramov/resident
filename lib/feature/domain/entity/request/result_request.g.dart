// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultRequest _$ResultRequestFromJson(Map<String, dynamic> json) =>
    ResultRequest(
      id: json['question_id'] as String,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => AnswerRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultRequestToJson(ResultRequest instance) =>
    <String, dynamic>{
      'question_id': instance.id,
      'answers': instance.answers,
    };
