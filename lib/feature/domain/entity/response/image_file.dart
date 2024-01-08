import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_file.g.dart';

@JsonSerializable()
@HiveType(typeId: 11)
class ImageFile extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? guid;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final int? size;
  @HiveField(4)
  final String? extension;
  @HiveField(5)
  final String? path;

  const ImageFile({this.id, this.guid, this.name, this.size, this.extension, this.path});

  ImageFile copyWith({String? id, String? guid, String? name, int? size, String? extension, String? path}) {
    return ImageFile(
      id: id ?? this.id,
      guid: guid ?? this.guid,
      name: name ?? this.name,
      size: size ?? this.size,
      extension: extension ?? this.extension,
      path: path ?? this.path,
    );
  }

  factory ImageFile.fromJson(Map<String, dynamic> json) {
    return _$ImageFileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ImageFileToJson(this);

  @override
  List<Object?> get props => [id, guid, name, size, extension, path];
}
