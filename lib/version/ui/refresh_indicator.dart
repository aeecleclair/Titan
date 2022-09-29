import 'package:flutter/material.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/version/tools/constants.dart';

class VersionRefresher extends Refresher {
  const VersionRefresher(
      {Key? key,
      required Future Function() onRefresh,
      required Widget child})
      : super(
            key: key,
            onRefresh: onRefresh,
            child: child,
            col: VersionColorConstants.darkGrey);
}
