// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlocAdapter extends TypeAdapter<Bloc> {
  @override
  final int typeId = 8;

  @override
  Bloc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bloc(
      id: fields[0] as String,
      name: fields[1] as Message,
    );
  }

  @override
  void write(BinaryWriter writer, Bloc obj) {
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
      other is BlocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bloc _$BlocFromJson(Map<String, dynamic> json) => Bloc(
      id: json['id'] as String,
      name: Message.fromJson(json['name'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BlocToJson(Bloc instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
