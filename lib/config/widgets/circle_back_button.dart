import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';
import 'package:text_repeater/features/presentation/bloc/text/local/local_text_bloc.dart';

import '../items/borders/container_borders.dart';
import '../items/colors/app_colors.dart';

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () {
        context.read<LocalTextBloc>().add(const RemoveTextEvent());
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          border: ContainerBorders.containerMediumBorder,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: context.paddingAllLow,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.kBlue20,
            size: context.dynamicHeight(0.027),
          ),
        ),
      ),
    );
  }
}
