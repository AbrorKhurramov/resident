import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/invoice_service.dart';

part 'invoice.g.dart';

@JsonSerializable()
class Invoice extends Equatable {
  final String? id;
  final int? amount;
  final String? note;
  final String? closedDate;
  final String? type;
  final String? invoice;
  final String? invoiceStatus;
  final String? createdDate;
  @JsonKey(name: 'serviceMinList')
  final List<InvoiceService> invoiceService;

  const Invoice(
      {this.id,
      this.amount,
      this.note,
      this.closedDate,
      this.type,
      this.invoice,
      this.invoiceStatus,
      this.createdDate,
      required this.invoiceService});

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return _$InvoiceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  Invoice copyWith(
      {String? id,
      int? amount,
      String? note,
      String? closedDate,
      String? type,
      String? invoice,
      String? invoiceStatus,
      String? createdDate,
      List<InvoiceService>? invoiceService}) {
    return Invoice(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        note: note ?? this.note,
        closedDate: closedDate ?? this.closedDate,
        type: type ?? this.type,
        invoice: invoice ?? this.invoice,
        invoiceStatus: invoiceStatus ?? this.invoiceStatus,
        createdDate: createdDate ?? this.createdDate,
        invoiceService: invoiceService ?? this.invoiceService);
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        note,
        closedDate,
        type,
        invoice,
        invoiceStatus,
        createdDate,
        invoiceService,
      ];
}
