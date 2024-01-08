import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/request/answer_request.dart';

part 'result_request.g.dart';

@JsonSerializable()
class ResultRequest extends Equatable {
  @JsonKey(name: "question_id")
  final String id;
  final List<AnswerRequest>? answers;

  const ResultRequest({required this.id, this.answers});

  factory ResultRequest.fromJson(Map<String, dynamic> json) {
    return _$ResultRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResultRequestToJson(this);

  ResultRequest copyWith({String? id, List<AnswerRequest>? answers}) {
    return ResultRequest(id: id ?? this.id, answers: answers ?? this.answers);
  }

  @override
  List<Object?> get props => [id, answers];
}
