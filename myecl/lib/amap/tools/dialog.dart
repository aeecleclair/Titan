import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';

class AMAPDialog extends CustomDialogBox {
  const AMAPDialog(
      {Key? key, required String title,
      required String descriptions,
      required Function() onYes})
      : super(
        key: key,
            title: title,
            descriptions: descriptions,
            onYes: onYes,
            titleColor: AMAPColorConstants.textDark,
            descriptionColor: AMAPColorConstants.enabled,
            yesColor: AMAPColorConstants.gradient2,
            noColor: AMAPColorConstants.redGradient1);
}
