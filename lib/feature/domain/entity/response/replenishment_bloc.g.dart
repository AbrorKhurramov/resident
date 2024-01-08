// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replenishment_bloc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReplenishmentBlocAdapter extends TypeAdapter<ReplenishmentBloc> {
  @override
  final int typeId = 0;

  @override
  ReplenishmentBloc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReplenishmentBloc(
      id: fields[0] as String,
      name: fields[1] as Message,
      complex: fields[2] as Complex?,
    );
  }

  @override
  void write(BinaryWriter writer, ReplenishmentBloc obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.complex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReplenishmentBlocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplenishmentBloc _$ReplenishmentBlocFromJson(Map<String, dynamic> json) =>
    ReplenishmentBloc(
      id: json['id'] as String,
      name: Message.fromJson(json['name'] as Map<String, dynamic>),
      complex: json['complex'] == null
          ? null
          : Complex.fromJson(json['complex'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReplenishmentBlocToJson(ReplenishmentBloc instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'complex': instance.complex,
    };
