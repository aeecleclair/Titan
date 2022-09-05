import 'package:flutter/material.dart';
import 'package:myecl/tools/dialog.dart';

class BookingDialog extends CustomDialogBox {
  BookingDialog(
      {Key? key,
      required String title,
      required String descriptions,
      required Function() onYes})
      : super(
          key: key,
          title: title,
          descriptions: descriptions,
          onYes: onYes,
          titleColor: Colors.grey.shade800,
          descriptionColor: Colors.grey.shade500,
          yesColor: Colors.red.shade700,
          noColor: Colors.green.shade700,
        );
}
