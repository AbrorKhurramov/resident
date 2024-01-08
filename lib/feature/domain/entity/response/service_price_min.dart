import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_price_min.g.dart';

@JsonSerializable()
class ServicePriceMin extends Equatable{
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'price')
  final int? price;

  const ServicePriceMin({this.id,this.name,this.price});








  factory ServicePriceMin.fromJson(Map<String, dynamic> json) {
    return _$ServicePriceMinFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ServicePriceMinToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    price
  ];
}