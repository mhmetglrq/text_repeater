import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_repeater/features/presentation/bloc/onboard/local/local_onboard_bloc.dart';
import 'package:text_repeater/injection_container.dart';

import 'features/presentation/bloc/text/local/local_text_bloc.dart';
import 'my_app.dart';

///TODO Add increment event to features
///TODO as a reward of the ad should be features

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LocalOnboardBloc>()),
        BlocProvider(create: (context) => sl<LocalTextBloc>()),
      ],
      child: BlocProvider<LocalOnboardBloc>(
        create: (context) => sl()..add(const GetOnboardStatusEvent()),
        child: const MyApp(),
      ),
    ),
  );
}
