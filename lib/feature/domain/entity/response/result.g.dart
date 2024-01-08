// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      questionId: json['question_id'] as String,
      resultVariants: (json['variants'] as List<dynamic>)
          .map((e) => ResultVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAnswers: json['total_answers'] as int,
      totalUsers: json['total_users'] as int,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'question_id': instance.questionId,
      'variants': instance.resultVariants,
      'total_answers': instance.totalAnswers,
      'total_users': instance.totalUsers,
    };
