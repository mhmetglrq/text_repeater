// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:text_repeater/features/presentation/views/home.dart';
import 'package:text_repeater/features/presentation/views/onboard.dart';
import 'package:text_repeater/features/presentation/views/text_repeater.dart';
import 'package:text_repeater/features/presentation/views/text_reverser.dart';
import 'package:text_repeater/features/presentation/views/text_sorter.dart';
import 'package:text_repeater/features/presentation/views/word_cloud.dart';
import '../../features/presentation/views/text_randomizer.dart';
import '../models/text_model.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onboard:
        return _fadeRoute(
          settings: settings,
          view: const Onboard(),
        );
      case RouteNames.home:
        return _fadeRoute(
          settings: settings,
          view: const Home(),
        );
      case RouteNames.textRepeater:
        final args = settings.arguments as TextModel?;

        return _fadeRoute(
          settings: settings,
          view: TextRepeater(
            textModel: args,
          ),
        );
      case RouteNames.textRandomizer:
        final args = settings.arguments as TextModel?;

        return _fadeRoute(
          settings: settings,
          view: TextRandomizer(
            textModel: args,
          ),
        );
      case RouteNames.wordCloud:
        final args = settings.arguments as TextModel?;

        return _fadeRoute(
          settings: settings,
          view: WordCloud(
            textModel: args,
          ),
        );
      case RouteNames.textSorting:
        final args = settings.arguments as TextModel?;

        return _fadeRoute(
          settings: settings,
          view: TextSorting(
            textModel: args,
          ),
        );
      case RouteNames.reverseText:
        final args = settings.arguments as TextModel?;

        return _fadeRoute(
          settings: settings,
          view: TextReverser(
            textModel: args,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> _slideRoute({
    required RouteSettings settings,
    required Widget view,
    Duration duration = const Duration(milliseconds: 500),
    Offset begin = const Offset(0, 1),
    Offset end = Offset.zero,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (animation, __, child) => view,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: begin,
            end: end,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _fadeRoute({
    required RouteSettings settings,
    required Widget view,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (animation, __, child) => view,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _scaleRoute({
    required RouteSettings settings,
    required Widget view,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (animation, __, child) => view,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _rotateRoute({
    required RouteSettings settings,
    required Widget view,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (animation, __, child) => view,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: animation,
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _sizeRoute({
    required RouteSettings settings,
    required Widget view,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (animation, __, child) => view,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
    );
  }
}
