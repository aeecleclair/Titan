import 'package:flutter/material.dart';
import 'package:myecl/tools/functions.dart';

void displayLoginToast(BuildContext context, TypeMsg type, String text) {
  return displayToast(
      context,
      type,
      text,
      Colors.lightGreenAccent,
      const Color.fromARGB(255, 139, 243, 19),
      const Color.fromARGB(255, 255, 153, 89),
      const Color.fromARGB(255, 243, 147, 13),
      const Color.fromARGB(255, 255, 255, 255));
}
