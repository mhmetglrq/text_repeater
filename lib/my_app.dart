import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';
import 'package:text_repeater/config/router/route_names.dart';
import 'package:text_repeater/config/themes/app_theme.dart';
import 'package:text_repeater/features/presentation/bloc/onboard/local/local_onboard_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/l10n/l10n.dart';
import 'config/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalOnboardBloc, LocalOnboardState>(
      builder: (newContext, state) {
        if (state is OnboardSuccessState) {
          return MaterialApp(
            title: newContext.locale?.repeatTextMenuTitle ?? "Text Repeater",
            supportedLocales: L10n.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: AppTheme.lightTheme(context),
            onGenerateRoute: AppRouter.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            initialRoute:
                (state.status ?? false) ? RouteNames.home : RouteNames.onboard,
          );
        } else if (state is OnboardLoadingState ||
            state is OnboardInitialState) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else {
          return MaterialApp(
            title: 'Text Repeater',
            supportedLocales: L10n.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
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
