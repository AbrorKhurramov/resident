// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_file.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageFileAdapter extends TypeAdapter<ImageFile> {
  @override
  final int typeId = 11;

  @override
  ImageFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageFile(
      id: fields[0] as String?,
      guid: fields[1] as String?,
      name: fields[2] as String?,
      size: fields[3] as int?,
      extension: fields[4] as String?,
      path: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageFile obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.guid)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.size)
      ..writeByte(4)
      ..write(obj.extension)
      ..writeByte(5)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageFile _$ImageFileFromJson(Map<String, dynamic> json) => ImageFile(
      id: json['id'] as String?,
      guid: json['guid'] as String?,
      name: json['name'] as String?,
      size: json['size'] as int?,
      extension: json['extension'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$ImageFileToJson(ImageFile instance) => <String, dynamic>{
      'id': instance.id,
      'guid': instance.guid,
      'name': instance.name,
      'size': instance.size,
      'extension': instance.extension,
      'path': instance.path,
    };
