import 'package:flutter/material.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';
import 'package:text_repeater/config/router/route_names.dart';

enum TextFeatures {
  textRepeater("repeat", "Text Repeater"),
  textRandomize("randomize", "Text Randomizer"),
  textSort("sort", "Text Sorting"),
  textReverse("reverse", "Reverse Text"),
  textWordCloud("wordCloud", "Word Cloud Generation");

  final String value;
  final String title;
  const TextFeatures(this.value, this.title);
}

extension ConvertType on String {
  String toEnum() {
    switch (this) {
      case 'repeat':
        return TextFeatures.textRepeater.title;
      case 'randomize':
        return TextFeatures.textRandomize.title;
      case 'sort':
        return TextFeatures.textSort.title;
      case 'reverse':
        return TextFeatures.textReverse.title;
      case 'wordCloud':
        return TextFeatures.textWordCloud.title;
      default:
        return TextFeatures.textRepeater.title;
    }
  }

  String getPath() {
    switch (this) {
      case 'repeat':
        return RouteNames.textRepeater;
      case 'randomize':
        return RouteNames.textRandomizer;
      case 'sort':
        return RouteNames.textSorting;
      case 'reverse':
        return RouteNames.reverseText;
      case 'wordCloud':
        return RouteNames.wordCloud;
      default:
        return RouteNames.textRepeater;
    }
  }

  String localizedName(BuildContext context) {
    switch (this) {
      case 'repeat':
        return context.locale?.repeatTextMenuTitle ??
            TextFeatures.textRepeater.title;
      case 'randomize':
        return context.locale?.randomTextMenuTitle ??
            TextFeatures.textRandomize.title;
      case 'sort':
        return context.locale?.sortTextMenuTitle ?? TextFeatures.textSort.title;
      case 'reverse':
        return context.locale?.reverseTextMenuTitle ??
            TextFeatures.textReverse.title;
      case 'wordCloud':
        return context.locale?.wordCloudMenuTitle ??
            TextFeatures.textWordCloud.title;
      default:
        return TextFeatures.textRepeater.title;
    }
  }
}
