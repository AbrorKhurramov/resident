// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replenishment_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplenishmentDetailsResponse _$ReplenishmentDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ReplenishmentDetailsResponse(
      replenishmentBloc:
          ReplenishmentBloc.fromJson(json['blocMin'] as Map<String, dynamic>),
      replenishmentApartment: ReplenishmentApartment.fromJson(
          json['apartmentMin'] as Map<String, dynamic>),
      fee: (json['fee'] as num).toDouble(),
    );

Map<String, dynamic> _$ReplenishmentDetailsResponseToJson(
        ReplenishmentDetailsResponse instance) =>
    <String, dynamic>{
      'blocMin': instance.replenishmentBloc,
      'apartmentMin': instance.replenishmentApartment,
      'fee': instance.fee,
    };
