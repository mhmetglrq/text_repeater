import 'package:flutter/material.dart';
import 'package:text_repeater/config/router/route_names.dart';
import 'package:text_repeater/config/themes/app_theme.dart';

import 'config/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Repeater',
      theme: AppTheme.lightTheme(context),
      onGenerateRoute: AppRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.onboard,
    );
  }
}
