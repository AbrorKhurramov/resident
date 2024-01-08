import 'package:resident/core/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/screen/story/story_screen.dart';
import 'package:resident/main.dart';

class AppNews extends StatefulWidget {
  const AppNews({Key? key}) : super(key: key);

  @override
  State<AppNews> createState() => _AppNewsState();
}

class _AppNewsState extends State<AppNews> {
  int page = 0;

  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().getNews(page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {
        if (state.stateStatus == StateStatus.failure) {
          MyApp.failureHandling(context, state.loadingFailure!);
        } else if (state.stateStatus == StateStatus.paginationLoading) {
          MyApp.failureHandling(context, state.paginationFailure!);
        }
      },
      builder: (context, state) {
        switch (state.stateStatus) {
          case StateStatus.loading:
            return Center(child: CircularProgressIndicator());
          case StateStatus.initial:
          case StateStatus.success:
            BasePaginationListResponse<Newness> response = state.response!;
            return Visibility(
              visible: response.data.isNotEmpty,
              child: Container(
                height: 100,
                alignment: Alignment.centerLeft,
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _initNewItem(response.data[index], index);
                    },
                    separatorBuilder: (context, index) {
                      return AppDimension.horizontalSize_24;
                    },
                    itemCount: response.data.length),
              ),
            );
          case StateStatus.failure:
            return AppDimension.defaultSize;
          default:
            return AppDimension.defaultSize;
        }
      },
    );
  }

  Widget _initNewItem(Newness newness, int index) {
    var name =  newness.name?.translate(
        context.read<LanguageCubit>().state.languageCode) ??
        '';
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouteName.storyScreen,
            arguments: StoryScreenParams(
                list: context.read<NewsCubit>().state.response!.data,
                activeIndex: index));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: Colors.black.withOpacity(0.1), width: 0.5),
              image: DecorationImage(
                  image: NetworkImage(newness.imageFile!.path!),
                  fit: BoxFit.fill),
            ),
            width: 56,
            height: 56,
          ),
          AppDimension.verticalSize_8,
          Text(
           name.length>10?"${name.substring(0,10)}...":name,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: AppColor.c4000, fontSize: 12.sf(context)),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
