import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer_variant.g.dart';

@JsonSerializable()
class AnswerVariant extends Equatable {
  @JsonKey(name: "variant_id")
  final String variantId;

  const AnswerVariant({required this.variantId});

  factory AnswerVariant.fromJson(Map<String, dynamic> json) {
    return _$AnswerVariantFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AnswerVariantToJson(this);

  AnswerVariant copyWith({String? variantId}) {
    return AnswerVariant(variantId: variantId ?? this.variantId);
  }

  @override
  List<Object?> get props => [variantId];
}
