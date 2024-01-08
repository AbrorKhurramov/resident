import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/invoice_cubit/invoice_state.dart';
import 'package:either_dart/either.dart';

class InvoiceCubit extends RepositoryCubit<InvoiceState> {
  final InvoiceUseCase invoiceUseCase;

  InvoiceCubit({required this.invoiceUseCase})
      : super(InvoiceState(stateStatus: StateStatus.initial));

  void getInvoiceById(String apartmentId, String invoiceId) {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    invoiceUseCase
        .call(InvoiceUseCaseParams(apartmentId, invoiceId, cancelToken))
        .fold(
            (left) => emit(state.copyWith(
                stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(
                stateStatus: StateStatus.success, response: right)));
  }
}
