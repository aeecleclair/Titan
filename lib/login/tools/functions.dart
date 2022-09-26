import 'package:flutter/material.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/login/class/account_type.dart';

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

String AccountTypeToID(AccountType type) {
  switch (type) {
    case AccountType.student:
      return '39691052-2ae5-4e12-99d0-7a9f5f2b0136';
    case AccountType.staff:
      return '703056c4-be9d-475c-aa51-b7fc62a96aaa';
    case AccountType.admin:
      return '0a25cb76-4b63-4fd3-b939-da6d9feabf28';
    case AccountType.association:
      return '29751438-103c-42f2-b09b-33fbb20758a7';
  }
}
