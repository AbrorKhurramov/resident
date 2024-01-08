import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_arrow_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/screen/appeal/component/create_appeal_bottom_sheet.dart';
import 'package:resident/main.dart';

class AppealListComponent extends StatefulWidget {
  const AppealListComponent({Key? key}) : super(key: key);

  @override
  State<AppealListComponent> createState() => _AppealListComponentState();
}

class _AppealListComponentState extends State<AppealListComponent> {
  final PagingController<int, AppealType> _pagingController = PagingController(
    firstPageKey: 0,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    context.read<AppealCubit>().getInitialAppeal(
        context.read<AppCubit>().getActiveApartment().id, pageKey);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppealCubit, AppealState>(
      listener: (context, state) {
        if (state.stateStatus == StateStatus.success) {
          BasePaginationListResponse<AppealType> response = state.response!;
          if (response.totalPages == response.currentPage + 1) {
            _pagingController.appendLastPage(response.data);
          } else {
            _pagingController.appendPage(
                response.data, response.currentPage + 1);
          }
        } else if (state.stateStatus == StateStatus.failure) {
          MyApp.failureHandling(context, state.loadingFailure!);
        } else if (state.stateStatus == StateStatus.paginationFailure) {
          MyApp.failureHandling(context, state.paginationLoadingFailure!);
        }
      },
      builder: (context, state) {
        return PagedListView<int, AppealType>.separated(
          pagingController: _pagingController,
          padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          builderDelegate: PagedChildBuilderDelegate<AppealType>(
            itemBuilder: (context, item, index) {
              return _initItem(item, index);
            },
          ),
          separatorBuilder: (BuildContext context, int index) {
            return AppDimension.verticalSize_12;
          },
        );
      },
    );
  }

  Widget _initItem(AppealType appealType, int index) {
    return AppArrowCard(
        label: appealType.name
                .translate(context.read<LanguageCubit>().state.languageCode) ??
            '',
        onPressed: () {
          showAppModalBottomSheet(
              context: context,
              builder: (context) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (_) => AppImageCubit(
                            sendFileUseCase: getIt<SendFileUseCase>())),
                    BlocProvider(
                        create: (_) => CreateAppealCubit(
                            createAppealUseCase: getIt<CreateAppealUseCase>())),
                  ],
                  child: CreateAppealBottomSheet(appealType: appealType),
                );
              });
        });
  }
}
