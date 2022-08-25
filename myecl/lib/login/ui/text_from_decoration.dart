import 'package:flutter/material.dart';
import 'package:myecl/login/tools/constants.dart';

InputDecoration registerInputDecoration({required String hintText}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
    hintStyle: const TextStyle(color: Colors.white, fontSize: 18),
    hintText: hintText,
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: LoginColorConstants.gradient1),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: LoginColorConstants.gradient1),
    ),
    errorStyle: const TextStyle(color: Colors.white),
  );
}

InputDecoration signInInputDecoration({required String hintText}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
    hintStyle: const TextStyle(fontSize: 18),
    hintText: hintText,
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 124, 124, 124)),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 124, 124, 124)),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: LoginColorConstants.gradient2),
    ),
    focusedErrorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: LoginColorConstants.gradient2),
    ),
    errorStyle: const TextStyle(color: LoginColorConstants.gradient2),
  );
}
