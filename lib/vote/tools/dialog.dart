import 'package:flutter/material.dart';
import 'package:myecl/tools/dialog.dart';
import 'package:myecl/vote/tools/constants.dart';

class VoteDialog extends CustomDialogBox {
  const VoteDialog(
      {Key? key,
      required String title,
      required String descriptions,
      required Function() onYes})
      : super(
            key: key,
            title: title,
            descriptions: descriptions,
            onYes: onYes,
            titleColor: VoteColorConstants.green1,
            descriptionColor: VoteColorConstants.green2,
            yesColor: VoteColorConstants.green3,
            noColor: VoteColorConstants.green4);
}
