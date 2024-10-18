import 'package:text_repeater/config/router/route_names.dart';

import '../models/menu_item.dart';

class MenuConstants {
  MenuConstants._();

  static final List<MenuItem> menuItems = [
    MenuItem(
      title: 'Text Repeater',
      description: 'Repeat any text multiple times',
      route: RouteNames.textRepeater,
    ),
    MenuItem(
      title: 'Text Randomizer',
      description: 'Randomize words or characters in your text',
      route: RouteNames.textRandomizer,
    ),
    MenuItem(
      title: 'Word Cloud Generation',
      description: 'Generate a word cloud from your text',
      route: RouteNames.wordCloud,
    ),
    MenuItem(
      title: 'Text Sorting',
      description: 'Sort the words in your text alphabetically',
      route: RouteNames.textSorting,
    ),
    MenuItem(
      title: 'Reverse Text',
      description: 'Reverse your text completely',
      route: RouteNames.reverseText,
    ),
  ];
}
