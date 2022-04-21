import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Theme(
      data: ThemeData(
          colorScheme: const ColorScheme.light(
        primary: Color.fromARGB(255, 9, 147, 39),
      )),
      child: Form(key: _formKey, child: Container()),
    );
  }
}
