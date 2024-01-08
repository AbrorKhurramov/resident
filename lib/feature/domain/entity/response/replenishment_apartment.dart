import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'replenishment_apartment.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class ReplenishmentApartment extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int floor;
  @JsonKey(name: 'floor_id')
  @HiveField(2)
  final String floorId;
  @JsonKey(name: 'bloc_id')
  @HiveField(3)
  final String blocId;
  @JsonKey(name: 'house_id')
  @HiveField(4)
  final String houseId;
  @JsonKey(name: 'entrance_id')
  @HiveField(5)
  final String entranceId;
  @JsonKey(name: 'complex_id')
  @HiveField(6)
  final String complexId;
  @JsonKey(name: 'prefix_number')
  @HiveField(7)
  final String prefixNumber;
  @JsonKey(name: 'number_apartment')
  @HiveField(8)
  final int numberApartment;
  @HiveField(9)
  final int type;
  @JsonKey(name: 'number_of_rooms')
  @HiveField(10)
  final int numberOfRooms;
  @JsonKey(name: 'total_area')
  @HiveField(11)
  final double totalArea;
  @JsonKey(name: 'living_area')
  @HiveField(12)
  final double livingArea;
  @HiveField(13)
  final bool selected;

  const ReplenishmentApartment({
    required this.id,
    required this.floor,
    required this.floorId,
    required this.blocId,
    required this.houseId,
    required this.entranceId,
    required this.complexId,
    required this.prefixNumber,
    required this.numberApartment,
    required this.type,
    required this.numberOfRooms,
    required this.totalArea,
    required this.livingArea,
    required this.selected,
  });

  factory ReplenishmentApartment.fromJson(Map<String, dynamic> json) {
    return _$ReplenishmentApartmentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReplenishmentApartmentToJson(this);

  @override
  List<Object?> get props => [
        id,
        floor,
        floorId,
        blocId,
        houseId,
        entranceId,
        complexId,
        prefixNumber,
        numberApartment,
        type,
        numberOfRooms,
        totalArea,
        livingArea,
        selected
      ];
}
