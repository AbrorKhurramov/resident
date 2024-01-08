import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

part 'survey_list.g.dart';

@JsonSerializable()
class SurveyList extends Equatable {
  final String id;
  final Message name;
  final int type;
  final String expiryDate;
  final Message description;
  final bool isExpired;
  final bool isAnswered;
  @JsonKey(ignore: true)
  late final SurveyType surveyType;

  SurveyList(
      {required this.id,
      required this.name,
      required this.type,
      required this.expiryDate,
      required this.description,
      required this.isExpired,
      required this.isAnswered}) {
    surveyType = type == 1 ? SurveyType.survey : SurveyType.vote;
  }

  factory SurveyList.fromJson(Map<String, dynamic> json) {
    return _$SurveyListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SurveyListToJson(this);

  SurveyList copyWith(
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
    return SurveyList(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        expiryDate: expiryDate ?? this.expiryDate,
        description: description ?? this.description,
        isExpired: isExpired ?? this.isExpired,
        isAnswered: isAnswered ?? this.isAnswered);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        expiryDate,
        description,
        isExpired,
        isAnswered,
        surveyType
      ];
}
