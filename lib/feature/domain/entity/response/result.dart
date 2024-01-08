import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/result_variant.dart';

part 'result.g.dart';

@JsonSerializable()
class Result extends Equatable {
  @JsonKey(name: 'question_id')
  final String questionId;
  @JsonKey(name: 'variants')
  final List<ResultVariant> resultVariants;
  @JsonKey(name: 'total_answers')
  final int totalAnswers;
  @JsonKey(name: 'total_users')
  final int totalUsers;

  const Result({
    required this.questionId,
    required this.resultVariants,
    required this.totalAnswers,
    required this.totalUsers,
  });


  factory Result.fromJson(Map<String, dynamic> json) {
    return _$ResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResultToJson(this);


  Result copyWith({
    String? questionId,
    List<ResultVariant>? resultVariants,
    int? totalAnswers,
    int? totalUsers,
  }) {
    return Result(
        questionId: questionId ?? this.questionId,
        resultVariants: resultVariants ?? this.resultVariants,
        totalAnswers: totalAnswers ?? this.totalAnswers,
        totalUsers: totalUsers ?? this.totalUsers);
  }

  @override
  List<Object?> get props => [
        questionId,
        resultVariants,
        totalAnswers,
        totalUsers,
      ];
}
