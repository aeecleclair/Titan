import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';

class AmapRefresher extends Refresher {
  const AmapRefresher(
      {Key? key, required Future Function() onRefresh, required Widget child})
      : super(
            key: key,
            onRefresh: onRefresh,
            child: child,
            col: AMAPColorConstants.greenGradient1);
}
