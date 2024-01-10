


import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/domain/entity_package.dart';


part 'indication_history_param.g.dart';

@JsonSerializable()
class IndicationHistoryParam extends FilterRequestParam{

  @JsonKey(name: 'counter_id')
  final String? counterId;


  IndicationHistoryParam( {this.counterId,String? dateFrom,String? dateTo,int? size, required int page}) : super(page: page,dateFrom: dateFrom,size:size,dateTo: dateTo);


  factory IndicationHistoryParam.fromJson(Map<String, dynamic> json) {
    return _$IndicationHistoryParamFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$IndicationHistoryParamToJson(this);

  @override
  Map<String, dynamic> queryParameters() {
    Map<String, dynamic> queryParameters = super.queryParameters();
    if(counterId!=null) {
      queryParameters["counter_id"]  = counterId;
    }

    return queryParameters;
  }

  @override
  List<Object?> get props => [
  super.props,
    counterId
  ];
}