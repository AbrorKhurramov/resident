import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/pay_invoice_cubit/pay_invoice_state.dart';
import 'package:either_dart/either.dart';

class PayInvoiceCubit extends RepositoryCubit<PayInvoiceState> {
  final PayInvoiceUseCase payInvoiceUseCase;

  PayInvoiceCubit({required this.payInvoiceUseCase})
      : super(const PayInvoiceState(stateStatus: StateStatus.initial));

  void payInvoice(String apartmentId,String invoiceId) {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    payInvoiceUseCase
        .call(PayInvoiceUseCaseParams(apartmentId,invoiceId, cancelToken))
        .fold(
            (left) => emit(state.copyWith(
                stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(
                stateStatus: StateStatus.success, response: right)));
  }
}
