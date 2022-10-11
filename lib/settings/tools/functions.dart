import 'package:flutter/material.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

void displaySettingsToast(BuildContext context, TypeMsg type, String text) {
  return displayToast(
      context,
      type,
      text,
      SettingsColorConstants.gradient1,
      SettingsColorConstants.gradient2,
      SettingsColorConstants.background2,
      SettingsColorConstants.background2,
      SettingsColorConstants.background);
}

