// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replenishment_apartment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReplenishmentApartmentAdapter
    extends TypeAdapter<ReplenishmentApartment> {
  @override
  final int typeId = 1;

  @override
  ReplenishmentApartment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReplenishmentApartment(
      id: fields[0] as String,
      floor: fields[1] as int,
      floorId: fields[2] as String,
      blocId: fields[3] as String,
      houseId: fields[4] as String,
      entranceId: fields[5] as String,
      complexId: fields[6] as String,
      prefixNumber: fields[7] as String,
      numberApartment: fields[8] as int,
      type: fields[9] as int,
      numberOfRooms: fields[10] as int,
      totalArea: fields[11] as double,
      livingArea: fields[12] as double,
      selected: fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ReplenishmentApartment obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.floor)
      ..writeByte(2)
      ..write(obj.floorId)
      ..writeByte(3)
      ..write(obj.blocId)
      ..writeByte(4)
      ..write(obj.houseId)
      ..writeByte(5)
      ..write(obj.entranceId)
      ..writeByte(6)
      ..write(obj.complexId)
      ..writeByte(7)
      ..write(obj.prefixNumber)
      ..writeByte(8)
      ..write(obj.numberApartment)
      ..writeByte(9)
      ..write(obj.type)
      ..writeByte(10)
      ..write(obj.numberOfRooms)
      ..writeByte(11)
      ..write(obj.totalArea)
      ..writeByte(12)
      ..write(obj.livingArea)
      ..writeByte(13)
      ..write(obj.selected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReplenishmentApartmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplenishmentApartment _$ReplenishmentApartmentFromJson(
        Map<String, dynamic> json) =>
    ReplenishmentApartment(
      id: json['id'] as String,
      floor: json['floor'] as int,
      floorId: json['floor_id'] as String,
      blocId: json['bloc_id'] as String,
      houseId: json['house_id'] as String,
      entranceId: json['entrance_id'] as String,
      complexId: json['complex_id'] as String,
      prefixNumber: json['prefix_number'] as String,
      numberApartment: json['number_apartment'] as int,
      type: json['type'] as int,
      numberOfRooms: json['number_of_rooms'] as int,
      totalArea: (json['total_area'] as num).toDouble(),
      livingArea: (json['living_area'] as num).toDouble(),
      selected: json['selected'] as bool,
    );

Map<String, dynamic> _$ReplenishmentApartmentToJson(
        ReplenishmentApartment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'floor': instance.floor,
      'floor_id': instance.floorId,
      'bloc_id': instance.blocId,
      'house_id': instance.houseId,
      'entrance_id': instance.entranceId,
      'complex_id': instance.complexId,
      'prefix_number': instance.prefixNumber,
      'number_apartment': instance.numberApartment,
      'type': instance.type,
      'number_of_rooms': instance.numberOfRooms,
      'total_area': instance.totalArea,
      'living_area': instance.livingArea,
      'selected': instance.selected,
    };
