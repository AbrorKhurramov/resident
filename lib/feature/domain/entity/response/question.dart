import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/domain/entity_package.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  final String id;
  final bool status;
  final Message question;
  final int type;
  final String note;
  final Message description;
  final List<Variant>? variants;
  @JsonKey(ignore: true)
  final List<String>? answersId;

  const Question(
      {required this.id,
      required this.status,
      required this.question,
      required this.type,
      required this.note,
      required this.description,
      required this.variants,
      this.answersId});

  factory Question.fromJson(Map<String, dynamic> json) {
    return _$QuestionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  Question copyWith(
      {String? id,
      bool? status,
      Message? question,
      int? type,
      String? note,
      Message? description,
      List<Variant>? variants,
      List<String>? answersId}) {
    return Question(
        id: id ?? this.id,
        status: status ?? this.status,
        question: question ?? this.question,
        type: type ?? this.type,
        note: note ?? this.note,
        description: description ?? this.description,
        variants: variants ?? this.variants,
        answersId: answersId ?? this.answersId);
  }

  @override
  List<Object?> get props => [
        id,
        status,
        question,
        type,
        note,
        description,
        variants,
        answersId,
      ];
}
