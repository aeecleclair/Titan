import 'package:flutter/material.dart';
import 'package:myecl/loan/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';

class LoanRefresher extends Refresher {
  const LoanRefresher(
      {Key? key,
      required Future Function() onRefresh,
      required Widget child})
      : super(
            key: key,
            onRefresh: onRefresh,
            child: child,
            col: LoanColorConstants.background2);
}
