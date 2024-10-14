import 'package:flutter/material.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';

import '../items/colors/app_colors.dart';

class BorderedButton extends StatelessWidget {
  const BorderedButton(
      {super.key,
      required this.text,
      this.onPressed,
      this.isFullWidth = true,
      this.isBordered = true,
      this.color,
      this.textStyle});
  final String text;
  final Function()? onPressed;
  final bool isFullWidth;
  final bool isBordered;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? AppColors.kWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: isBordered
            ? const BorderSide(
                color: AppColors.kBlack,
              )
            : BorderSide.none,
      ),
      minWidth: isFullWidth ? double.infinity : context.dynamicWidth(0.5),
      child: Padding(
        padding: context.paddingVerticalLow,
        child: Text(
          text,
          style: textStyle ??
              context.textTheme.titleMedium?.copyWith(
                color: AppColors.kBlack,
              ),
        ),
      ),
    );
  }
}
