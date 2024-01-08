import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

part 'survey.g.dart';

@JsonSerializable()
class Survey extends Equatable {
  final String id;
  final Message name;
  final int type;
  final String expiryDate;
  final Message description;
  final bool isExpired;
  final List<Question> questions;
  final List<Result> results;
  final List<Answer> answers;
  @JsonKey(ignore: true)
  late final SurveyType surveyType;

  Survey(
      {required this.id,
      required this.name,
      required this.type,
      required this.expiryDate,
      required this.description,
      required this.isExpired,
      required this.questions,
      required this.results,
      required this.answers}) {
    surveyType = type == 1 ? SurveyType.survey : SurveyType.vote;
  }

  factory Survey.fromJson(Map<String, dynamic> json) {
    return _$SurveyFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SurveyToJson(this);

  Survey copyWith(
      {String? id,
      Message? name,
      int? type,
      String? expiryDate,
      Message? description,
      bool? isExpired,
      List<Question>? questions,
      List<Result>? results,
      List<Answer>? answers,
      bool? isAnswered}) {
    return Survey(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        expiryDate: expiryDate ?? this.expiryDate,
        description: description ?? this.description,
        isExpired: isExpired ?? this.isExpired,
        questions: questions ?? this.questions,
        results: results ?? this.results,
        answers: answers ?? this.answers);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        expiryDate,
        description,
        isExpired,
        questions,
        results,
        answers,
        surveyType
      ];
}
