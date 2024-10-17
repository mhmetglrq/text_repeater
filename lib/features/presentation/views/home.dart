import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:text_repeater/config/constants/menu_constants.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';

import '../../../config/items/borders/container_borders.dart';
import '../../../config/items/colors/app_colors.dart';
import '../../../config/utility/enum/image_enum.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingAllDefault,
          child: Column(
            children: [
              CustomAppBar(
                title: "Home",
                leading: Container(
                  decoration: BoxDecoration(
                    border: ContainerBorders.containerMediumBorder,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: context.paddingAllLow,
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        ImageEnum.menu.toSvg,
                      ),
                    ),
                  ),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    border: ContainerBorders.containerMediumBorder,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: context.paddingAllLow,
                    child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        ImageEnum.notification.toSvg,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: context.paddingVerticalLow,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Text(
                        'Welcome to\nText Repeater 🙌',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: AppColors.kBlue100,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SvgPicture.asset(
                        ImageEnum.ellipse.toSvg,
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
                    itemCount: MenuConstants.menuItems.length,
                    padEnds: false,
                    controller: PageController(viewportFraction: 0.7),
                    itemBuilder: (context, index) {
                      final menuItem = MenuConstants.menuItems[index];
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
                                ),
                                Text(
                                  menuItem.description,
                                  style: context.textTheme.bodyMedium?.copyWith(
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
                      'Recent Texts',
                      style: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.kBlue100,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'See all',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.kBlue100,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: context.paddingBottomLow,
                      child: Container(
                        padding: context.paddingAllDefault,
                        decoration: BoxDecoration(
                          border: ContainerBorders.containerMediumBorder,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Text Repeater',
                              style: context.textTheme.headlineMedium?.copyWith(
                                color: AppColors.kNeutral40,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi.',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.kBlue100,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '2 min ago',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.kNeutral40,
                                fontWeight: FontWeight.w300,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.leading,
    this.title = "",
    this.trailing,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading ??
                Container(
                  decoration: BoxDecoration(
                    border: ContainerBorders.containerMediumBorder,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: context.paddingAllLow,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                      ),
                    ),
                  ),
                ),
            trailing ?? const SizedBox()
          ],
        ),
        Text(
          title,
          style: context.textTheme.headlineLarge?.copyWith(
            color: AppColors.kBlue100,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
