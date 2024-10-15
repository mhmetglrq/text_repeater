import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_repeater/features/presentation/bloc/onboard/onboard_bloc.dart';
import 'package:text_repeater/injection_container.dart';

import 'my_app.dart';

Future<void> main() async {
  await initializeDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<OnboardBloc>(),
        ),
      ],
      child: BlocProvider<OnboardBloc>(
        create: (context) => sl()..add(GetOnboardStatusEvent()),
        child: const MyApp(),
      ),
    ),
  );
}
