import 'package:flutter/material.dart';
import 'package:myecl/admin/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';

class AdminDialog extends CustomDialogBox {
  const AdminDialog(
      {Key? key,
      required String title,
      required String descriptions,
      required Function() onYes})
      : super(
            key: key,
            title: title,
            descriptions: descriptions,
            onYes: onYes,
            titleColor: AdminColorConstants.gradient1,
            descriptionColor: Colors.black,
            yesColor: AdminColorConstants.gradient2,
            noColor: AdminColorConstants.redGradient1);
}
