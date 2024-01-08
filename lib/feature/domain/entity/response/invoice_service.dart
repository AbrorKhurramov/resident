import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/domain/entity_package.dart';

part 'invoice_service.g.dart';

@JsonSerializable()
class InvoiceService extends Equatable {
  @JsonKey(name: 'name')
  final Message? message;
  @JsonKey(name: 'result')
  final int? result;
  @JsonKey(name: 'type')
  final String? type;





  const InvoiceService({this.message, this.result, this.type});

  factory InvoiceService.fromJson(Map<String, dynamic> json) {
    return _$InvoiceServiceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvoiceServiceToJson(this);

  @override
  List<Object?> get props => [message, result , type];
}
