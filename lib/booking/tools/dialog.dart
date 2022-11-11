import 'package:flutter/material.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/dialog.dart';

class BookingDialog extends CustomDialogBox {
  const BookingDialog(
      {Key? key,
      required String title,
      required String descriptions,
      required Function() onYes})
      : super(
          key: key,
          title: title,
          descriptions: descriptions,
          onYes: onYes,
            titleColor: BookingColorConstants.gradient1,
            descriptionColor: Colors.black,
            yesColor: BookingColorConstants.gradient2,
            noColor: BookingColorConstants.background2
        );
}
