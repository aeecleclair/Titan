import 'package:flutter/material.dart';
import 'package:myecl/booking/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';

class BookingRefresher extends Refresher {
  const BookingRefresher(
      {Key? key,
      required GlobalKey<RefreshIndicatorState> keyRefresh,
      required Future Function() onRefresh,
      required Widget child})
      : super(
            key: key,
            keyRefresh: keyRefresh,
            onRefresh: onRefresh,
            child: child,
            col: BookingColorConstants.lightBlue);
}
