import 'package:flutter/material.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';

class LoanDialog extends CustomDialogBox {
  const LoanDialog(
      {Key? key, required String title,
      required String descriptions,
      required Function() onYes})
      : super(
          key: key,
          title: title,
          descriptions: descriptions,
          onYes: onYes,
          titleColor: LoanColorConstants.orange,
          descriptionColor: LoanColorConstants.lightGrey,
          yesColor: LoanColorConstants.lightOrange,
          noColor: LoanColorConstants.lightOrange,
        );
}