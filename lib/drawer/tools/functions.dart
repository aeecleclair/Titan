import 'package:flutter/material.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

void displayDrawerToast(BuildContext context, TypeMsg type, String text) {
  return displayToast(
      context,
      type,
      text,
      DrawerColorConstants.darkBlue,
      DrawerColorConstants.lightBlue,
      DrawerColorConstants.fakePageShadow,
      DrawerColorConstants.fakePageBlue,
      DrawerColorConstants.lightText);
}
