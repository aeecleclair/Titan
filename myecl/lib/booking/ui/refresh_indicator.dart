import 'package:flutter/material.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';

class BookingRefresher extends Refresher {
  const BookingRefresher(
      {Key? key,
      required Future Function() onRefresh,
      required Widget child})
      : super(
            key: key,
            onRefresh: onRefresh,
            child: child,
            col: BookingColorConstants.lightBlue);
}
