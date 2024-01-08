import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/image_file.dart';

part 'appeal_request.g.dart';

@JsonSerializable()
class AppealRequest extends Equatable {
  @JsonKey(name: 'apartment_id')
  final String apartmentId;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'file_ids')
  final List<String> imageFileId;
  @JsonKey(name: 'type')
  final int type;

  const AppealRequest({
    required this.apartmentId,
    required this.content,
    required this.imageFileId,
    required this.type,
  });

  factory AppealRequest.fromJson(Map<String, dynamic> json) {
    return _$AppealRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppealRequestToJson(this);

  @override
  List<Object?> get props => [
        apartmentId,
        content,
        imageFileId,
        type,
      ];
}
