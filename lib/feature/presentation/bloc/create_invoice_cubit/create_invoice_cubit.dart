import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/create_invoice_cubit/create_invoice_state.dart';
import 'package:either_dart/either.dart';

class CreateInvoiceCubit extends RepositoryCubit<CreateInvoiceState> {
  final CreateInvoiceUseCase createInvoiceUseCase;

  CreateInvoiceCubit(
      {required this.createInvoiceUseCase, required Counter chosenCounter})
      : super(CreateInvoiceState(
            stateStatus: StateStatus.initial, counter: chosenCounter));

  void chooseCounter(Counter chosenCounter) {
    emit(state.copyWith(counter: chosenCounter));
  }

  void changeReading(String reading) {
    emit(state.copyWith(reading: reading));
  }

  void createInvoice({required String apartmentId}) {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    createInvoiceUseCase
        .call(CreateInvoiceUseCaseParams(
            apartmentId: apartmentId,
            serviceId: state.counter.service!.id!,
            servicePriceId: state.counter.servicePriceMin!.id!,
            result: int.parse(state.reading!.replaceAll(" ", "")),
            cancelToken: cancelToken))
        .fold(
            (left) => emit(state.copyWith(
                stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(
                stateStatus: StateStatus.success, response: right)));
  }
}
