import 'package:flutter/material.dart';

class ShowDialog {
  ShowDialog._();

  static void showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String buttonTitle,
    required Function() onPressed,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(buttonTitle),
            ),
          ],
        );
      },
    );
  }

  static void showLoadingDialog({
    required BuildContext context,
    required String content,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Text(content),
            ],
          ),
        );
      },
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String content,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: backgroundColor,
      ),
    );
  }

  static void showBottomSheet({
    required BuildContext context,
    required Widget child,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return child;
      },
    );
  }

  static void showBottomSheetDialog({
    required BuildContext context,
    required Widget child,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: child,
        );
      },
    );
  }

  static void showCustomDialog({
    required BuildContext context,
    required Widget child,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return child;
      },
    );
  }

  static void showCustomDialogWithAnimation({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
    required Offset begin,
    required Offset end,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
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
      ),
    );
  }

  static void showCustomDialogWithFadeAnimation({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  static void showCustomDialogWithScaleAnimation({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
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
      ),
    );
  }

  static void showCustomDialogWithRotationAnimation({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return RotationTransition(
            turns: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  static void showCustomDialogWithSizeAnimation({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SizeTransition(
            sizeFactor: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  static void showCustomDialogWithSlideAnimation({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
    required Offset begin,
    required Offset end,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
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
      ),
    );
  }

  static void showCustomDialogWithRotationTransition({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return RotationTransition(
            turns: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  static void showCustomDialogWithScaleTransition({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
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
      ),
    );
  }

  static void showCustomDialogWithSizeTransition({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SizeTransition(
            sizeFactor: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  static void showCustomDialogWithFadeTransition({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  static void showCustomDialogWithAlignTransition({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Align(
            child: child,
          );
        },
      ),
    );
  }

  static void showCustomDialogWithDefaultTransition({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ),
    );
  }

  static void showCustomDialogWithCustomTransition({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
    required Widget Function(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) transitionsBuilder,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: transitionsBuilder,
      ),
    );
  }

  static void showCustomDialogWithCustomTransitionBuilder({
    required BuildContext context,
    required Widget child,
    required RouteSettings settings,
    required Duration duration,
    required RouteTransitionsBuilder transitionsBuilder,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: transitionsBuilder,
      ),
    );
  }
}
