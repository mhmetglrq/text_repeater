import 'package:flutter/material.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';
import 'package:text_repeater/config/router/route_names.dart';

import '../models/menu_item.dart';

class MenuConstants {
  MenuConstants._();

  static List<MenuItem> menuItems(BuildContext context) => [
        MenuItem(
          title: "${context.locale?.repeatTextMenuTitle}",
          description: "${context.locale?.repeatTextMenuDesc}",
          route: RouteNames.textRepeater,
        ),
        MenuItem(
          title: "${context.locale?.randomTextMenuTitle}",
          description: "${context.locale?.randomTextMenuDesc}",
          route: RouteNames.textRandomizer,
        ),
        MenuItem(
          title: "${context.locale?.wordCloudMenuTitle}",
          description: "${context.locale?.wordCloudMenuDesc}",
          route: RouteNames.wordCloud,
        ),
        MenuItem(
          title: "${context.locale?.sortTextMenuDesc}",
          description: "${context.locale?.sortTextMenuDesc}",
          route: RouteNames.textSorting,
        ),
        MenuItem(
          title: "${context.locale?.reverseTextMenuTitle}",
          description: "${context.locale?.reverseTextMenuDesc}",
          route: RouteNames.reverseText,
        ),
      ];
}
