import 'package:resident/core/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:resident/feature/presentation/component/app_empty_card.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/screen/document/component/document_bottom_sheet.dart';
import 'package:resident/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DocumentListComponent extends StatefulWidget {
   DocumentListComponent({Key? key,required this.dateFrom,required this.dateTo}) : super(key: key);
  String dateFrom;
  String dateTo;
  @override
  State<DocumentListComponent> createState() => _DocumentListComponentState();
}

class _DocumentListComponentState extends State<DocumentListComponent> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;
  int page = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<DocumentListCubit>()
        .getDocuments(context.read<AppCubit>().getActiveApartment().id,widget.dateFrom,widget.dateTo);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DocumentListCubit, DocumentListState>(
      listener: (context, state) {
        if (state.stateStatus == StateStatus.failure) {
          MyApp.failureHandling(context, state.loadingFailure!);
        } else if (state.stateStatus == StateStatus.paginationFailure) {
          MyApp.failureHandling(context, state.paginationLoadingFailure!);
        }
      },
      builder: (context, state) {
        if (state.stateStatus == StateStatus.paginationLoading ||
            state.stateStatus == StateStatus.success) {
          if (state.response!.data.isNotEmpty) {
            BasePaginationListResponse<Document> response = state.response!;
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<DocumentListCubit>()
                      .getDocuments(context.read<AppCubit>().getActiveApartment().id,widget.dateFrom,widget.dateTo);
                },

                child: GroupListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  sectionsCount: state.sortedDocument.keys.toList().length,
                  countOfItemInSection: (int section) {
                    if (response.totalPages != response.currentPage + 1 &&
                        state.sortedDocument.values.length - 1 == section) {
                      return state.sortedDocument.values
                              .toList()[section]
                              .length +
                          1;
                    }
                    return state.sortedDocument.values.toList()[section].length;
                  },
                  itemBuilder: (context, indexPath) {
                    if (response.totalPages != response.currentPage + 1 &&
                        state.sortedDocument.values.length - 1 ==
                            indexPath.section &&
                        indexPath.index ==
                            state.sortedDocument.values
                                .toList()[indexPath.section]
                                .length) {
                      if (state.stateStatus != StateStatus.paginationLoading) {
                          context
                            .read<DocumentListCubit>()
                            .getPaginationDocuments(
                                context.read<AppCubit>().getActiveApartment().id,
                                response.currentPage + 1);
                      }
                      return const Center(child: CircularProgressIndicator());
                    }

                    return _initItem(state.sortedDocument.values
                        .toList()[indexPath.section][indexPath.index]);
                  },
                  groupHeaderBuilder: (BuildContext context, int section) {
                    return _initGroupHeader(
                        state.sortedDocument.keys.toList()[section]);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  sectionSeparatorBuilder: (context, section) =>
                      const SizedBox(height: 12),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppEmptyCard(
                  path: 'assets/icons/empty_document.svg',
                  description: _appLocalization.empty_document),
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
    //           fontSize: 12.sf(context),
    //           color: AppColor.c3000,
    //         ),
    //   ),
    // );
  }

  Widget _initItem(Document document) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            showAppModalBottomSheet(
                context: context,
                builder: (context) {
                  return DocumentBottomSheet(
                    document: document,
                    appLocalizations: _appLocalization,
                  );
                });
          },
          style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor, fixedSize: const Size(double.infinity, double.infinity), backgroundColor: Colors.white,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(16)))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    document.message?.translate(
                            context.read<LanguageCubit>().languageCode()) ??
                        '',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 14.sf(context), color: AppColor.c4000),
                  ),
                ),
                AppDimension.horizontalSize_8,
                Text(
                  document.createdDate.toString().getHourAndMinute(),
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 13.sf(context), color: AppColor.c3000),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
