import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/core/extension/string_extension.dart';
import 'package:resident/feature/domain/entity/response/bloc.dart';
import 'package:resident/feature/domain/entity/response/complex.dart';
import 'package:resident/feature/domain/entity/response/entrance.dart';
import 'package:resident/feature/domain/entity/response/floor.dart';
import 'package:resident/feature/domain/entity/response/house.dart';
import 'package:resident/feature/domain/entity/response/image_file.dart';

part 'apartment.g.dart';

@JsonSerializable()
@HiveType(typeId: 4)
class Apartment extends Equatable {
  @HiveField(0)
  final String id;
  @JsonKey(name: 'number_apartment')
  @HiveField(1)
  final int numberApartment;
  @HiveField(2)
  final int type;
  @JsonKey(name: 'number_of_rooms')
  @HiveField(3)
  final int numberOfRooms;
  @JsonKey(name: 'total_area')
  @HiveField(4)
  final double totalArea;
  @JsonKey(name: 'living_area')
  @HiveField(5)
  final double livingArea;
  @HiveField(6)
  final String note;
  @HiveField(7)
  final bool status;
  @HiveField(8)
  final Floor? floor;
  @HiveField(9)
  final Entrance? entrance;
  @HiveField(10)
  final House? house;
  @HiveField(11)
  final Bloc? bloc;
  @HiveField(12)
  final Complex? complex;
  @HiveField(13)
  final bool? selected;
  @HiveField(14)
  final ImageFile? backgroundLogo;
  @HiveField(15)
  final ImageFile? logo;
  @HiveField(16)
  final String? account;
  @HiveField(17)
  @JsonKey(name: 'deposit_sum')
  final double depositSum;

  const Apartment(
      {required this.id,
      required this.numberApartment,
      required this.type,
      required this.numberOfRooms,
      required this.totalArea,
      required this.livingArea,
      required this.note,
      required this.status,
      this.floor,
      this.entrance,
      this.house,
      this.bloc,
      this.complex,
      this.selected,
      this.backgroundLogo,
      this.logo,
      this.account,
      required this.depositSum});

  Apartment copyWith(
      {String? id,
      int? numberApartment,
      int? type,
      int? numberOfRooms,
      double? totalArea,
      double? livingArea,
      String? note,
      bool? status,
      Floor? floor,
      Entrance? entrance,
      House? house,
      Bloc? bloc,
      Complex? complex,
      bool? selected,
      ImageFile? backgroundLogo,
      ImageFile? logo,
      String? account,
      double? depositSum}) {
    return Apartment(
        id: id ?? this.id,
        numberApartment: numberApartment ?? this.numberApartment,
        type: type ?? this.type,
        numberOfRooms: numberOfRooms ?? this.numberOfRooms,
        totalArea: totalArea ?? this.totalArea,
        livingArea: livingArea ?? this.livingArea,
        note: note ?? this.note,
        status: status ?? this.status,
        floor: floor ?? this.floor,
        entrance: entrance ?? this.entrance,
        house: house ?? this.house,
        bloc: bloc ?? this.bloc,
        complex: complex ?? this.complex,
        selected: selected ?? this.selected,
        backgroundLogo: backgroundLogo ?? this.backgroundLogo,
        logo: logo ?? this.logo,
        account: account ?? this.account,
        depositSum: depositSum ?? this.depositSum);
  }

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return _$ApartmentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApartmentToJson(this);

  String getApartmentInfo(String languageCode, String flatLabel) {
    String blocInfo = bloc!.name.translate(languageCode) ?? '';
    String apartmentNumber = numberApartment.toString();

    return '$blocInfo, ${flatLabel.capitalize()} $apartmentNumber';
  }

  String complexInfo() {
    return complex?.name ?? '';
  }

  @override
  List<Object?> get props => [
        id,
        numberApartment,
        type,
        numberOfRooms,
        totalArea,
        livingArea,
        note,
        status,
        floor,
        entrance,
        house,
        bloc,
        complex,
        selected,
        backgroundLogo,
        logo,
        account,
        depositSum
      ];
}
