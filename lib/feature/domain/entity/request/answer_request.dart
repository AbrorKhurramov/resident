import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer_request.g.dart';

@JsonSerializable()
class AnswerRequest extends Equatable {
  @JsonKey(name: 'variant_id')
  final String id;

  const AnswerRequest({required this.id});

  factory AnswerRequest.fromJson(Map<String, dynamic> json) {
    return _$AnswerRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AnswerRequestToJson(this);

  AnswerRequest copyWith({String? id}) {
    return AnswerRequest(id: id ?? this.id);
  }

  @override
  List<Object?> get props => [id];
}
