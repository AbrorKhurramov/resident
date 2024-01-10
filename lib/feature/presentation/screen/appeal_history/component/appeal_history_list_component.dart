import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/component/app_empty_card.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/screen/appeal_history/component/appeal_bottom_sheet.dart';
import 'package:resident/injection/injection_container.dart';
import 'package:resident/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppealHistoryListComponent extends StatefulWidget {
   AppealHistoryListComponent({Key? key,this.status,this.type, required this.dateFrom,required this.dateTo}) : super(key: key);
  int? status;
  int? type;
  String dateFrom;
  String dateTo;
  @override
  State<AppealHistoryListComponent> createState() => _AppealHistoryListComponentState();
}

class _AppealHistoryListComponentState extends State<AppealHistoryListComponent> {
  int page = 0;
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AppealHistoryCubit>().getAppealHistory(
          context.read<AppCubit>().getActiveApartment().id,widget.status,widget.type,widget.dateFrom,widget.dateTo
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppealHistoryCubit, AppealHistoryState>(
      listener: (context, state) {
        if (state.stateStatus == StateStatus.failure) {
          MyApp.failureHandling(context, state.loadingFailure!);
        } else if (state.stateStatus == StateStatus.paginationFailure) {
          MyApp.failureHandling(context, state.paginationLoadingFailure!);
        }
      },
      builder: (context, state) {
        if (state.stateStatus == StateStatus.paginationLoading || state.stateStatus == StateStatus.success) {
          if (state.response!.data.isNotEmpty) {
            BasePaginationListResponse<AppealResponse> response = state.response!;
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<AppealHistoryCubit>().getAppealHistory(
                      context.read<AppCubit>().getActiveApartment().id,widget.status,widget.type,widget.dateFrom,widget.dateTo
                  );
                },
                child: GroupListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  sectionsCount: state.sortedAppeal.keys.toList().length,
                  countOfItemInSection: (int section) {
                    if (response.totalPages != response.currentPage + 1 &&
                        state.sortedAppeal.values.length - 1 == section) {
                      return state.sortedAppeal.values.toList()[section].length + 1;
                    }
                    return state.sortedAppeal.values.toList()[section].length;
                  },
                  itemBuilder: (context, indexPath) {
                    if (response.totalPages != response.currentPage + 1 &&
                        state.sortedAppeal.values.length - 1 == indexPath.section &&
                        indexPath.index == state.sortedAppeal.values.toList()[indexPath.section].length) {
                      if (state.stateStatus != StateStatus.paginationLoading) {
                        context.read<AppealHistoryCubit>().getPaginationAppealHistory(
                            context.read<AppCubit>().getActiveApartment().id, response.currentPage + 1);
                      }
                      return const Center(child: CircularProgressIndicator());
                    }

                    return _initItem(state.sortedAppeal.values.toList()[indexPath.section][indexPath.index]);
                  },
                  groupHeaderBuilder: (BuildContext context, int section) {
                    return _initGroupHeader(state.sortedAppeal.keys.toList()[section]);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  sectionSeparatorBuilder: (context, section) => const SizedBox(height: 12),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppEmptyCard(
                  path: 'assets/icons/empty_service_card.svg', description: _appLocalization.empty_history_appeal_description),
            );
          }
        }
        if (state.stateStatus == StateStatus.loading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _initGroupHeader(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
        ),
        child: Text(
          label.getDateWithoutHour(_appLocalization),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 12.sf(context),
                color: AppColor.c3000,
              ),
        ),
      ),
    );

    // return Container(
    //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(16)),
    //     color: Colors.white,
    //   ),
    //   child: Text(
    //     label,
    //     style: Theme.of(context).textTheme.headline3!.copyWith(
    //           fontSize: 12,
    //           color: AppColor.c3000,
    //         ),
    //   ),
    // );
  }

  Widget _initItem(AppealResponse appealResponse) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            context.read<AppealHistoryCubit>().onTapAppeal(appealResponse.id.toString());
            showAppModalBottomSheet(
                context: context,
                builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => AppImageCubit(sendFileUseCase: getIt<SendFileUseCase>())),
                    ],
                    child: BlocProvider(
                      create: (_) => AppImageCubit(
                          sendFileUseCase: getIt<SendFileUseCase>(), imageFile: appealResponse.imageFiles),
                      child: AppealBottomSheet(appeal: appealResponse),
                    ),
                  );
                }).then((value) {
              context.read<ProfileCubit>().getNotificationsCount(context.read<AppCubit>().getActiveApartment().id);
            });
          },
          style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor, padding: EdgeInsets.zero, backgroundColor: Colors.white,
              fixedSize: const Size(double.infinity, double.infinity),
              elevation: 0,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.all(Radius.circular(16)))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _initItemHeader(appealResponse),
                AppDimension.verticalSize_16,
                _initItemStatusAndAmount(appealResponse),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _initItemHeader(AppealResponse appealResponse) {
    return Row(
      children: [
        SvgPicture.asset('assets/icons/appeal.svg'),
        AppDimension.horizontalSize_8,
        Text(
          appealResponse.appealType.name.translate(context.read<LanguageCubit>().state.languageCode) ?? '',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14.sf(context), color: AppColor.c4000),
        ),
      ],
    );
  }

  Widget _initItemStatusAndAmount(AppealResponse appealResponse) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: _getStatusColor(appealResponse.status),
          ),
          child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                _getAppealStatusLabel(appealResponse.status).toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 10.sf(context),
                      color: Colors.white,
                    ),
              )),
        ),
        AppDimension.horizontalSize_8,
        const Spacer(),
        Text(
          appealResponse.createdDate.getHourAndMinute(),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 16.sf(context),
                color: AppColor.c3000,
              ),
        )
      ],
    );
  }


  Color _getStatusColor(int status){
    switch(status){
      case 0: return AppColor.c6000;
      case 1:return AppColor.c70000;
      case 2: return AppColor.c7000;
      case 3: return AppColor.c50000;
      default: return AppColor.c4000;
    }
  }

  String _getAppealStatusLabel(int appealStatusId) {
    switch (appealStatusId) {
      case 0:
        return AppealStatus.newStatus.getLabel(_appLocalization);
      case 1:
        return AppealStatus.inProgressStatus.getLabel(_appLocalization);
      case 2:
        return AppealStatus.confirmedStatus.getLabel(_appLocalization);
      case 3:
        return AppealStatus.notConfirmedStatus.getLabel(_appLocalization);
        default:
        return AppealStatus.completed.getLabel(_appLocalization);
    }
  }
}
