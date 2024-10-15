import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_repeater/config/router/route_names.dart';
import 'package:text_repeater/config/themes/app_theme.dart';
import 'package:text_repeater/features/presentation/bloc/onboard/onboard_bloc.dart';

import 'config/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardBloc, OnboardState>(
      builder: (context, state) {
        if (state is OnboardSuccessState) {
          return MaterialApp(
            title: 'Text Repeater',
            theme: AppTheme.lightTheme(context),
            onGenerateRoute: AppRouter.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            initialRoute:
                (state.status ?? false) ? RouteNames.home : RouteNames.onboard,
          );
        } else if (state is OnboardLoadingState || state is OnboardInitialState) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else {
          return MaterialApp(
            title: 'Text Repeater',
            theme: AppTheme.lightTheme(context),
            onGenerateRoute: AppRouter.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            initialRoute: RouteNames.onboard,
          );
        }
      },
    );
  }
}
