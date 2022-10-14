import 'package:flutter/material.dart';
import 'package:myecl/others/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';

class OthersRefresher extends Refresher {
  const OthersRefresher(
      {Key? key,
      required Future Function() onRefresh,
      required Widget child})
      : super(
            key: key,
            onRefresh: onRefresh,
            child: child,
            col: OthersColorConstants.background);
}
