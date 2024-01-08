// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FloorAdapter extends TypeAdapter<Floor> {
  @override
  final int typeId = 5;

  @override
  Floor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Floor(
      id: fields[0] as String,
      name: fields[1] as Message,
    );
  }

  @override
  void write(BinaryWriter writer, Floor obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FloorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Floor _$FloorFromJson(Map<String, dynamic> json) => Floor(
      id: json['id'] as String,
      name: Message.fromJson(json['name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FloorToJson(Floor instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
