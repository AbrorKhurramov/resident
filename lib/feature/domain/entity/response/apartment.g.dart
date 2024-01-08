// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApartmentAdapter extends TypeAdapter<Apartment> {
  @override
  final int typeId = 4;

  @override
  Apartment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Apartment(
      id: fields[0] as String,
      numberApartment: fields[1] as int,
      type: fields[2] as int,
      numberOfRooms: fields[3] as int,
      totalArea: fields[4] as double,
      livingArea: fields[5] as double,
      note: fields[6] as String,
      status: fields[7] as bool,
      floor: fields[8] as Floor?,
      entrance: fields[9] as Entrance?,
      house: fields[10] as House?,
      bloc: fields[11] as Bloc?,
      complex: fields[12] as Complex?,
      selected: fields[13] as bool?,
      backgroundLogo: fields[14] as ImageFile?,
      logo: fields[15] as ImageFile?,
      account: fields[16] as String?,
      depositSum: fields[17] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Apartment obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.numberApartment)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.numberOfRooms)
      ..writeByte(4)
      ..write(obj.totalArea)
      ..writeByte(5)
      ..write(obj.livingArea)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.floor)
      ..writeByte(9)
      ..write(obj.entrance)
      ..writeByte(10)
      ..write(obj.house)
      ..writeByte(11)
      ..write(obj.bloc)
      ..writeByte(12)
      ..write(obj.complex)
      ..writeByte(13)
      ..write(obj.selected)
      ..writeByte(14)
      ..write(obj.backgroundLogo)
      ..writeByte(15)
      ..write(obj.logo)
      ..writeByte(16)
      ..write(obj.account)
      ..writeByte(17)
      ..write(obj.depositSum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApartmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apartment _$ApartmentFromJson(Map<String, dynamic> json) => Apartment(
      id: json['id'] as String,
      numberApartment: json['number_apartment'] as int,
      type: json['type'] as int,
      numberOfRooms: json['number_of_rooms'] as int,
      totalArea: (json['total_area'] as num).toDouble(),
      livingArea: (json['living_area'] as num).toDouble(),
      note: json['note'] as String,
      status: json['status'] as bool,
      floor: json['floor'] == null
          ? null
          : Floor.fromJson(json['floor'] as Map<String, dynamic>),
      entrance: json['entrance'] == null
          ? null
          : Entrance.fromJson(json['entrance'] as Map<String, dynamic>),
      house: json['house'] == null
          ? null
          : House.fromJson(json['house'] as Map<String, dynamic>),
      bloc: json['bloc'] == null
          ? null
          : Bloc.fromJson(json['bloc'] as Map<String, dynamic>),
      complex: json['complex'] == null
          ? null
          : Complex.fromJson(json['complex'] as Map<String, dynamic>),
      selected: json['selected'] as bool?,
      backgroundLogo: json['backgroundLogo'] == null
          ? null
          : ImageFile.fromJson(json['backgroundLogo'] as Map<String, dynamic>),
      logo: json['logo'] == null
          ? null
          : ImageFile.fromJson(json['logo'] as Map<String, dynamic>),
      account: json['account'] as String?,
      depositSum: (json['deposit_sum'] as num).toDouble(),
    );

Map<String, dynamic> _$ApartmentToJson(Apartment instance) => <String, dynamic>{
      'id': instance.id,
      'number_apartment': instance.numberApartment,
      'type': instance.type,
      'number_of_rooms': instance.numberOfRooms,
      'total_area': instance.totalArea,
      'living_area': instance.livingArea,
      'note': instance.note,
      'status': instance.status,
      'floor': instance.floor,
      'entrance': instance.entrance,
      'house': instance.house,
      'bloc': instance.bloc,
      'complex': instance.complex,
      'selected': instance.selected,
      'backgroundLogo': instance.backgroundLogo,
      'logo': instance.logo,
      'account': instance.account,
      'deposit_sum': instance.depositSum,
    };
