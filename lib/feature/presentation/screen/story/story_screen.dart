import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/screen/story/component/story_page_linear_list_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoryScreenParams {
  final List<Newness> list;
  final int activeIndex;

  StoryScreenParams({required this.list, required this.activeIndex});
}

class StoryScreen extends StatefulWidget {
  int activeIndex=0;
  static Route<dynamic> route(StoryScreenParams storyScreenParams) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => StoryCubit(StoryState(list: storyScreenParams.list, activeIndex: storyScreenParams.activeIndex)),
        child:  StoryScreen(activeIndex: storyScreenParams.activeIndex),
      );
    });
  }

   StoryScreen({Key? key,required this.activeIndex}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {

  late PageController _pageController ;

  late  AppLocalizations _appLocalization ;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
    _pageController = PageController(initialPage: widget.activeIndex, keepPage: true);

  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: BlocConsumer<StoryCubit, StoryState>(
            listener: (context, state) {
              if (state.activeIndex > state.list.length - 1) {
                Navigator.pop(context);
              } else {
                _pageController.jumpToPage(state.activeIndex);
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Positioned(
                    top: 16,
                    bottom: 16,
                    left: 8,
                    right: 8,
                    child: PageView.builder(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.5),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTapDown: (details) {

                                      context.read<StoryCubit>().changeActiveIndex(details,MediaQuery.of(context).size.width);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(24)),
                                      child: ShaderMask(
                                        shaderCallback: (rect) {
                                          return AppColor.newsGradient()
                                              .createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                                        },
                                        blendMode: BlendMode.srcATop,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(state.list[index].imageFile!.path!),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 32,
                                  left: 16,
                                  right: 16,
                                  child: Row(
                                    children: [
                                      _initNewItem(state.list[index]),
                                      AppDimension.horizontalSize_8,
                                      Text(
                                        state.list[index].name
                                                ?.translate(context.read<LanguageCubit>().state.languageCode) ??
                                            '',
                                        style: Theme.of(context).textTheme.headline3!.copyWith(
                                              color: Colors.white,
                                              fontSize: 14.sf(context),
                                            ),
                                      ),
                                      AppDimension.horizontalSize_8,
                                      Text(
                                        state.list[index].createdDate!.getDifferenceDateString(_appLocalization),
                                        style: Theme.of(context).textTheme.headline4!.copyWith(
                                              color: Colors.white.withOpacity(0.4),
                                              fontSize: 14.sf(context),
                                            ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  right: 16,
                                  bottom: 48,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.list[index].content!.translate(context.read<LanguageCubit>().languageCode())! ,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .copyWith(color: Colors.white, fontSize: 40.sf(context)),
                                      ),
                                      AppDimension.verticalSize_24,
                                      Text(
                                        state.list[index].subContent!.translate(context.read<LanguageCubit>().languageCode())! ,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(color: Colors.white, fontSize: 18.sf(context)),
                                        maxLines: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      },
                      itemCount: state.list.length,
                    ),
                  ),
                  Positioned(
                    top: 32,
                    left: 16,
                    right: 16,
                    child: StoryPageLinearListComponent(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _initNewItem(Newness newness) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.5),
        image: DecorationImage(image: NetworkImage(newness.imageFile!.path!), fit: BoxFit.fill),
      ),
      width: 32,
      height: 32,
    );
  }

  LinearGradient getCustomGradient() {
    return LinearGradient(
      colors: [Colors.pink, Colors.blueAccent],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(0.8, 0.0),
      stops: [0.0, 0.6],
      tileMode: TileMode.clamp,
    );
  }
}
