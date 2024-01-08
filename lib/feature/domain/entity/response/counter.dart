import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/service.dart';
import 'package:resident/feature/domain/entity/response/service_price_min.dart';

part 'counter.g.dart';

@JsonSerializable()
class Counter extends Equatable {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'serviceMin')
  final Service? service;
  @JsonKey(name: 'servicePriceMin')
  final ServicePriceMin? servicePriceMin;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'counterNumber')
  final String? counterNumber;
  @JsonKey(name: 'counterName')
  final String? counterName;
  @JsonKey(name: 'serviceResult')
  final int? serviceResult; 
  @JsonKey(name: 'balance')
  final int balance;
  @JsonKey(name: 'monthlyStatus')
  final bool status;
 @JsonKey(name: 'invoiceStatus')
  final bool invoiceStatus;

  const Counter({
    required this.id,
    this.service,
    this.servicePriceMin,
    required this.type,
    this.counterNumber,
    this.counterName,
    this.serviceResult,
    required this.balance,
    required this.status,
    required this.invoiceStatus,
  });

  factory Counter.fromJson(Map<String, dynamic> json) {
    return _$CounterFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CounterToJson(this);

  @override
  List<Object?> get props => [
        id,
        service,
        type,
        counterNumber,
        counterName,
        serviceResult,
    servicePriceMin,
        balance,
        status,
    invoiceStatus
      ];

  @override
  String toString() {
    return counterName.toString();
  }
}
