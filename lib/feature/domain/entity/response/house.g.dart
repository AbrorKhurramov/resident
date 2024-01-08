// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HouseAdapter extends TypeAdapter<House> {
  @override
  final int typeId = 7;

  @override
  House read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return House(
      id: fields[0] as String,
      name: fields[1] as Message,
    );
  }

  @override
  void write(BinaryWriter writer, House obj) {
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
      other is HouseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

House _$HouseFromJson(Map<String, dynamic> json) => House(
      id: json['id'] as String,
      name: Message.fromJson(json['name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HouseToJson(House instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
