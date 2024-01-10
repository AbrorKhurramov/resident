import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/domain/use_case/news_use_case/news_use_case.dart';
import 'package:resident/feature/presentation/bloc/news_cubit/news_state.dart';

class NewsCubit extends RepositoryCubit<NewsState> {
  late final NewsUseCase _newsUseCase;

  NewsCubit(NewsUseCase newsUseCase)
      : super(const NewsState(stateStatus: StateStatus.initial)) {
    _newsUseCase = newsUseCase;
  }

  Future<void> getNews(int page) async {
    emit(state.copyWith(stateStatus: StateStatus.loading));
         _newsUseCase.call(NewsUseCaseParams(page, cancelToken)).fold(
        (left) {
          if(left is CancelFailure) return;
          emit(state.copyWith(
              stateStatus: StateStatus.failure,
              loadingFailure: left,
            ));
        },
        (right) => emit(state.copyWith(
              stateStatus: StateStatus.success,
              response: right,
            )));
  }

  void getPaginationNews() async {
    emit(state.copyWith(stateStatus: StateStatus.paginationLoading));

    Either<Failure, BasePaginationListResponse<Newness>> call =
        await _newsUseCase.call(NewsUseCaseParams(
      state.response!.currentPage + 1,
      cancelToken,
    ));

    call.fold(
        (left) => emit(state.copyWith(
            stateStatus: StateStatus.paginationFailure, paginationFailure: left)),
        (right) => emit(state.copyWith(
            stateStatus: StateStatus.success,
            response: state.response!.copyWith(data: [
              ...state.response!.data,
              ...right.data,
            ]))));
  }
}
