import 'package:flutter/material.dart';

class ContainerBorders {
  static const double radius = 10.0;

  static BorderRadius borderRadius = BorderRadius.circular(radius);

  static BoxBorder containerSmallBorder = Border.all(
    color: Colors.grey,
    width: 0.5,
  );

  static BoxBorder containerMediumBorder = Border.all(
    color: Colors.grey,
    width: 1.0,
  );

  static BoxBorder containerLargeBorder = Border.all(
    color: Colors.grey,
    width: 2.0,
  );

  static BoxBorder containerExtraLargeBorder = Border.all(
    color: Colors.grey,
    width: 3.0,
  );
}
