import 'package:flutter/material.dart';
import 'package:myecl/booking/tools/constants.dart';
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
          titleColor: BookingColorConstants.softBlack,
          descriptionColor: BookingColorConstants.lightBlue,
          yesColor: BookingColorConstants.veryLightBlue,
          noColor: BookingColorConstants.darkBlue,
        );
}
