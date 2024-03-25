import 'package:flutter/material.dart';

class SDeCprincipal extends StatelessWidget {
  const SDeCprincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SDeC extends StatelessWidget {
  const SDeC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Entrée du SDeC',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SDeCprincipal());
  }
}
