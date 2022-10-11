import 'package:flutter/material.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';

class SettignsDialog extends CustomDialogBox {
  const SettignsDialog(
      {Key? key, required String title,
      required String descriptions,
      required Function() onYes})
      : super(
          key: key,
          title: title,
          descriptions: descriptions,
          onYes: onYes,
          titleColor: SettingsColorConstants.gradient2,
          descriptionColor: SettingsColorConstants.background2,
          yesColor: SettingsColorConstants.gradient1,
          noColor: SettingsColorConstants.background2,
        );
}