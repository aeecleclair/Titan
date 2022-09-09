import 'package:flutter/material.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';

class EventDialog extends CustomDialogBox {
  const EventDialog(
      {Key? key,
      required String title,
      required String descriptions,
      required Function() onYes})
      : super(
          key: key,
          title: title,
          descriptions: descriptions,
          onYes: onYes,
          titleColor: EventColorConstants.blueGradient2,
          descriptionColor: EventColorConstants.darkBlue,
          yesColor: EventColorConstants.redGradient1,
          noColor: EventColorConstants.blueGradient1,
        );
}
