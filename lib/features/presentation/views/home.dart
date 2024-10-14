import 'package:flutter/material.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: context.paddingAllDefault,
        child: const Column(
          children: [],
        ),
      ),
    );
  }
}
