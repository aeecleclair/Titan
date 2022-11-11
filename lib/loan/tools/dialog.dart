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
          titleColor: LoanColorConstants.gradient1,
          descriptionColor: Colors.black,
          yesColor: LoanColorConstants.gradient2,
          noColor: LoanColorConstants.background2,
        );
}