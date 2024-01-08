import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_result.g.dart';

@JsonSerializable()
class ServiceResult extends Equatable {
  @JsonKey(name: 'result')
  final int? result;
  @JsonKey(name: 'counterNumber')
  final String? counterNumber;
  @JsonKey(name: 'counterName')
  final String? counterName;
  @JsonKey(name: 'createdDate')
  final String? createdDate;

  const ServiceResult({
    this.result,
    this.counterName,
    this.counterNumber,
    this.createdDate,
  });

  String getCounterInfo() {
    if (counterName != null) {
      return counterName!;
    } else if (counterNumber != null) {
      return counterNumber!;
    }
    return '';
  }

  factory ServiceResult.fromJson(Map<String, dynamic> json) {
    return _$ServiceResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ServiceResultToJson(this);

  @override
  List<Object?> get props => [
        result,
        counterNumber,
        counterName,
        createdDate,
      ];
}
