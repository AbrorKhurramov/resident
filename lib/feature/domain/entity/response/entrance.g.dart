// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntranceAdapter extends TypeAdapter<Entrance> {
  @override
  final int typeId = 6;

  @override
  Entrance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Entrance(
      id: fields[0] as String,
      name: fields[1] as Message,
    );
  }

  @override
  void write(BinaryWriter writer, Entrance obj) {
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
      other is EntranceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entrance _$EntranceFromJson(Map<String, dynamic> json) => Entrance(
      id: json['id'] as String,
      name: Message.fromJson(json['name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EntranceToJson(Entrance instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
