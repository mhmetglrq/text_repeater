import 'package:flutter/material.dart';

import '../app_colors.dart';

class InputBorders {
  InputBorders._();

  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFFE9F1FF),
      width: 1,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(8), // Kenarları yuvarlatmak istersen
  );

  static OutlineInputBorder focusedInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFF756EF3),
      width: 1,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(8), // Kenarları yuvarlatmak istersen
  );

  static OutlineInputBorder errorInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFFFB2047),
      width: 1,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(8), // Kenarları yuvarlatmak istersen
  );

  static OutlineInputBorder successInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFF00D99A),
      width: 1,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(8), // Kenarları yuvarlatmak istersen
  );

  static OutlineInputBorder disabledInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Color(0xFFE9F1FF),
      width: 1,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(8), // Kenarları yuvarlatmak istersen
  );

  static const OutlineInputBorder enabledInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(
      color: Color(0xFFE9F1FF),
      width: 1.0,
    ),
  );

  static const OutlineInputBorder focusedErrorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(
      color: AppColors.kRed100,
      width: 2.0,
    ),
  );
}
