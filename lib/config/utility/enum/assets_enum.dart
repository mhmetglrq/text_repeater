import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AssetsEnum {
  messageBox('message_box'),
  menu('menu'),
  notification('notification'),
  ellipse('ellipse'),
  empty('empty'),
  ;

  final String value;
  const AssetsEnum(this.value);

  String get toPng => 'assets/images/$value.png';
  String get toSvg => 'assets/svg/$value.svg';
  String get toJson => 'assets/json/$value.json';

  Image get toPngImage => Image.asset(toPng);
  SvgPicture get toSvgImage => SvgPicture.asset(toSvg);
}
