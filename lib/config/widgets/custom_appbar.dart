import 'package:flutter/material.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';

import '../items/colors/app_colors.dart';
import 'circle_back_button.dart';

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
            leading ?? const CircleBackButton(),
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
