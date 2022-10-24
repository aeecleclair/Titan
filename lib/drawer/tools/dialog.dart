import 'package:flutter/material.dart';
import 'package:myecl/drawer/tools/constants.dart';
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
          titleColor: DrawerColorConstants.darkBlue,
          descriptionColor: DrawerColorConstants.lightBlue,
          yesColor: DrawerColorConstants.fakePageShadow,
          noColor: DrawerColorConstants.fakePageBlue,
        );
}
