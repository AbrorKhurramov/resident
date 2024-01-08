

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/replenishment_apartment.dart';
import 'package:resident/feature/domain/entity/response/replenishment_bloc.dart';

part 'replenishment_details_response.g.dart';

@JsonSerializable()
class ReplenishmentDetailsResponse extends Equatable{
  @JsonKey(name: 'blocMin')
  final ReplenishmentBloc replenishmentBloc;
  @JsonKey(name: 'apartmentMin')
  final ReplenishmentApartment replenishmentApartment;
  @JsonKey(name: 'fee')
  final double fee;

  const ReplenishmentDetailsResponse({
    required this.replenishmentBloc,
    required this.replenishmentApartment,
    required this.fee
});

  factory ReplenishmentDetailsResponse.fromJson(Map<String, dynamic> json) {
    return _$ReplenishmentDetailsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReplenishmentDetailsResponseToJson(this);

  @override
  List<Object?> get props => [
    replenishmentBloc,
    replenishmentApartment,
    fee
  ];


}