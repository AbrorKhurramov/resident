import 'package:json_annotation/json_annotation.dart';

import 'answer_variant.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  @JsonKey(name: "question_id")
  final String questionId;
  final List<AnswerVariant> answers;

  Answer({required this.questionId, required this.answers});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return _$AnswerFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  Answer copyWith({String? questionId, List<AnswerVariant>? answers}) {
    return Answer(
        questionId: questionId ?? this.questionId,
        answers: answers ?? this.answers);
  }
}
