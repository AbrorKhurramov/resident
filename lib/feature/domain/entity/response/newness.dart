import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/domain/entity_package.dart';

part 'newness.g.dart';

@JsonSerializable()
class Newness extends Equatable {
  final String? id;
  @JsonKey(name: 'name')
  final Message? name;
  @JsonKey(name: 'content')
  final Message? content;
  @JsonKey(name: 'subContent')
  final Message? subContent;
  @JsonKey(name: 'createdDate')
  final String? createdDate;
  @JsonKey(name: 'logo')
  final ImageFile? imageFile;

  const Newness({
    this.id,
    this.name,
    this.content,
    this.createdDate,
    this.subContent,
    this.imageFile,
  });

  Newness copyWith({String? id, Message? name, Message? content,String? createdDate, Message? subContent, ImageFile? imageFile}) {
    return Newness(
        id: id ?? this.id,
        name: name ?? this.name,
        createdDate: createdDate??this.createdDate,
        content: content ?? this.content,
        subContent: subContent ?? this.subContent,
        imageFile: imageFile ?? this.imageFile);
  }

  factory Newness.fromJson(Map<String, dynamic> json) {
    return _$NewnessFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewnessToJson(this);

  @override
  List<Object?> get props => [id, name, content,createdDate, subContent, imageFile];
}
