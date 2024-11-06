import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';
import 'package:text_repeater/config/router/route_names.dart';
import 'package:text_repeater/config/utility/enum/assets_enum.dart';
import 'package:text_repeater/features/presentation/bloc/onboard/local/local_onboard_bloc.dart';

import '../../../config/items/colors/app_colors.dart';
import '../../../config/widgets/bordered_button.dart';

class Onboard extends StatelessWidget {
  const Onboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.kPrimaryLight,
            height: context.dynamicHeight(1),
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 2; i++)
                        Padding(
                          padding: context.paddingTopLow,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                AssetsEnum.messageBox.toSvg,
                                height: context.dynamicHeight(0.05),
                              ),
                              Text(
                                "${context.locale?.iLoveYouText}",
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: context.dynamicHeight(0.015),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: context.paddingTopLow,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetsEnum.messageBox.toSvg,
                              height: context.dynamicHeight(0.055),
                            ),
                            Text(
                              "${context.locale?.iLoveYouText}",
                              style: context.textTheme.bodySmall?.copyWith(
                                fontSize: context.dynamicHeight(0.017),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (int i = 0; i < 2; i++)
                        Padding(
                          padding: context.paddingTopLow,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                AssetsEnum.messageBox.toSvg,
                                height: context.dynamicHeight(0.05),
                              ),
                              Text(
                                "${context.locale?.iLoveYouText}",
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: context.dynamicHeight(0.015),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AspectRatio(
              aspectRatio: 1,
              child: Card(
                elevation: 15,
                margin: EdgeInsets.zero,
                color: AppColors.kWhite,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: context.paddingAllHigh,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: context.paddingAllDefault,
                        child: Text(
                          "${context.locale?.welcomeOnboard}",
                          style: context.textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: context.paddingAllLow,
                        child: Text(
                          "${context.locale?.enterDashboard}",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.kNeutral50,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: context.paddingAllLow,
                        child: BorderedButton(
                          text: "${context.locale?.getStarted}",
                          color: AppColors.kPrimaryLight,
                          isBordered: false,
                          textStyle: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.kWhite,
                          ),
                          onPressed: () {
                            context.read<LocalOnboardBloc>().add(
                                  const SaveOnboardStatusEvent(true),
                                );
                            Navigator.pushNamed(context, RouteNames.home);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
