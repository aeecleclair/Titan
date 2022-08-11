import 'package:flutter/material.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';

class LoanRefresher extends Refresher {
  const LoanRefresher(
      {Key? key,
      required GlobalKey<RefreshIndicatorState> keyRefresh,
      required Future Function() onRefresh,
      required Widget child})
      : super(
            key: key,
            keyRefresh: keyRefresh,
            onRefresh: onRefresh,
            child: child,
            col: LoanColorConstants.darkGrey);
}
