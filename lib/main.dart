import 'package:flutter/material.dart';
import 'package:text_repeater/injection_container.dart';

import 'my_app.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MyApp());
}
