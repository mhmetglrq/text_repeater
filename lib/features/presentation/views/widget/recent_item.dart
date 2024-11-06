import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';

import '../../../../config/items/borders/container_borders.dart';
import '../../../../config/items/colors/app_colors.dart';
import '../../../../config/models/text_model.dart';
import '../../../../config/utility/helpers/ad_helper.dart';
import '../../../../config/utility/utils/date_utils.dart';
import '../../../../config/utility/utils/utils.dart';

import 'package:text_repeater/config/utility/enum/text_features.dart';

import '../../bloc/text/local/local_text_bloc.dart';

class RecentItem extends StatelessWidget {
  const RecentItem({
    super.key,
    required this.textModel,
  });

  final TextModel textModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalTextBloc, LocalTextState>(
      listener: (context, state) {
        if (state is LocalTextSuccessState) {
          if ((state.adCount ?? 1) % 3 == 0) {
            AdMobHelper().showRewardedInterstitialAd(onRewarded: () {
              Navigator.pushNamed(
                context,
                textModel.type?.getPath() ?? "",
                arguments: textModel,
              );
            }, onDismissed: () {
              context
                  .read<LocalTextBloc>()
                  .add(const IncrementAdCountEvent(adCount: 3));
            });
          }
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<LocalTextBloc>().add(const IncrementAdCountEvent());
            if (((state.adCount ?? 1) + 1) % 3 != 0) {
              Navigator.pushNamed(
                context,
                textModel.type?.getPath() ?? "",
                arguments: textModel,
              );
            }
          },
          child: Directionality(
            textDirection: context.locale?.localeName == "ar"
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Padding(
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
                      "${textModel.type?.localizedName(context)}",
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: AppColors.kNeutral40,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      textModel.text ?? "",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.kBlue100,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      INTLDateUtils.getFormattedDate(
                          textModel.createdAt ?? DateTime.now(), context),
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
            ),
          ),
        );
      },
    );
  }
}
