import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class ContainerBorders {
  static const double radius = 10.0;

  static BorderRadius borderRadius = BorderRadius.circular(radius);

  static BoxBorder containerSmallBorder = Border.all(
    color: AppColors.kBlue20,
    width: 0.5,
  );

  static BoxBorder containerMediumBorder = Border.all(
    color: AppColors.kBlue20,
    width: 1.0,
  );

  static BoxBorder containerLargeBorder = Border.all(
    color: AppColors.kBlue20,
    width: 2.0,
  );

  static BoxBorder containerExtraLargeBorder = Border.all(
    color: AppColors.kBlue20,
    width: 3.0,
  );
}
