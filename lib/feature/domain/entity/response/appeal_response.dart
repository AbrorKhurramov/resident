import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/appeal_type.dart';
import 'package:resident/feature/domain/entity/response/image_file.dart';
import 'package:resident/feature/domain/entity/response/reg_application_reply.dart';

part 'appeal_response.g.dart';

@JsonSerializable()
class AppealResponse extends Equatable {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'content')
  final String? content;
  @JsonKey(name: 'fileMinList')
  final List<ImageFile> imageFiles;
  @JsonKey(name: 'regStatus')
  final int status;
  @JsonKey(name: 'type')
  final AppealType appealType;
  @JsonKey(name: 'regApplicationReply')
  final dynamic regApplicationReply;
  @JsonKey(name: 'createdDate')
  final String createdDate;

  const AppealResponse({
    required this.id,
    this.content,
    required this.imageFiles,
    required this.status,
    required this.appealType,
    required this.regApplicationReply,
    required this.createdDate,
  });

  factory AppealResponse.fromJson(Map<String, dynamic> json) {
    return _$AppealResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppealResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        content,
        imageFiles,
        status,
        appealType,
        createdDate,
      ];
}
