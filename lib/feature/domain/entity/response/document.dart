import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/domain/entity_package.dart';

part 'document.g.dart';

@JsonSerializable()
class Document extends Equatable {
  final String? id;
  @JsonKey(name: 'name')
  final Message? message;
  @JsonKey(name: 'content')
  final Message? content;
  @JsonKey(name: 'logo')
  final ImageFile? imageFile;
  @JsonKey(name: 'createdDate')
  final String? createdDate;


  const Document({
    this.id,
    this.message,
    this.content,
    this.imageFile,
    this.createdDate
  });

  Document copyWith({
    String? id,
    Message? message,
    Message? content,
    ImageFile? imageFile,
    String? createdDate
  }) {
    return Document(
      id: id ?? this.id,
      message: message ?? this.message,
      content: content ?? this.content,
      imageFile: imageFile ?? this.imageFile,
      createdDate: createdDate ?? this.createdDate
    );
  }

  factory Document.fromJson(Map<String, dynamic> json) {
    return _$DocumentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DocumentToJson(this);


  @override
  List<Object?> get props => [id, message, content, imageFile,createdDate];
}
