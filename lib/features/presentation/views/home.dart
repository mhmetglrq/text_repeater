import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:text_repeater/config/constants/menu_constants.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';

import '../../../config/items/borders/container_borders.dart';
import '../../../config/items/colors/app_colors.dart';
import '../../../config/utility/enum/assets_enum.dart';
import '../../../config/utility/helpers/ad_helper.dart';
import '../bloc/text/local/local_text_bloc.dart';
import 'widget/recent_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<LocalTextBloc>().add(const GetSavedTextsEvent());
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Directionality(
        textDirection: context.locale?.localeName == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: context.paddingAllDefault,
              child: Column(
                children: [
                  Padding(
                    padding: context.paddingVerticalLow,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Align(
                            alignment: context.locale?.localeName == "ar"
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment:
                                  context.locale?.localeName == "ar"
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${context.locale?.welcomeTo}',
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
                                    color: AppColors.kBlue100,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${context.locale?.textRepeaterHome}',
                                  style:
                                      context.textTheme.titleMedium?.copyWith(
                                    color: AppColors.kBlue100,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(
                            AssetsEnum.ellipse.toSvg,
                            width: context.dynamicWidth(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: context.paddingVerticalLow,
                    child: SizedBox(
                      height: context.dynamicHeight(0.13),
                      child: PageView.builder(
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemCount: MenuConstants.menuItems(context).length,
                        padEnds: false,
                        controller: PageController(viewportFraction: 0.7),
                        itemBuilder: (context, index) {
                          final menuItem =
                              MenuConstants.menuItems(context)[index];
                          return Padding(
                            padding: context.paddingRightLow,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, menuItem.route);
                              },
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  color: _currentIndex == index
                                      ? AppColors.kPrimaryLight
                                      : AppColors.kNeutral10,
                                  borderRadius: BorderRadius.circular(10),
                                  border: _currentIndex == index
                                      ? null
                                      : ContainerBorders.containerSmallBorder,
                                ),
                                padding: context.paddingAllDefault,
                                duration: const Duration(milliseconds: 500),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      menuItem.title,
                                      style: context.textTheme.headlineMedium
                                          ?.copyWith(
                                        color: _currentIndex == index
                                            ? Colors.white
                                            : AppColors.kBlue100,
                                        fontWeight: FontWeight.w600,
                                        fontSize: context.dynamicHeight(0.023),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      menuItem.description,
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        color: AppColors.kNeutral30,
                                        fontSize: context.dynamicHeight(0.018),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: context.paddingVerticalLow,
                    child: Row(
                      children: [
                        Text(
                          '${context.locale?.recentTexts}',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.kBlue100,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<LocalTextBloc, LocalTextState>(
                      builder: (context, state) {
                        if (state is LocalTextSavedTextsLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is LocalTextSavedTextsSuccessState) {
                          return (state.savedTexts ?? []).isNotEmpty
                              ? RefreshIndicator(
                                  onRefresh: () async {
                                    context
                                        .read<LocalTextBloc>()
                                        .add(const GetSavedTextsEvent());
                                  },
                                  child: ListView.builder(
                                    itemCount: state.savedTexts?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final textModel =
                                          state.savedTexts![index];
                                      return RecentItem(textModel: textModel);
                                    },
                                  ),
                                )
                              : Center(
                                  child: Lottie.asset(
                                    AssetsEnum.empty.toJson,
                                    width: context.dynamicWidth(0.5),
                                  ),
                                );
                        } else {
                          return Center(
                            child: Text("${state.message}"),
                          );
                        }
                      },
                    ),
                  ),
                  AdMobHelper().getBannerAdWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
