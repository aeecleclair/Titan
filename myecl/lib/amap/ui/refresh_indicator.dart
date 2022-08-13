import 'package:flutter/material.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';

class AmapRefresher extends Refresher {
  const AmapRefresher(
      {Key? key, required GlobalKey<RefreshIndicatorState> keyRefresh,
      required Future Function() onRefresh,
      required Widget child})
      : super(
        key: key,
            keyRefresh: keyRefresh,
            onRefresh: onRefresh,
            child: child,
            col: AMAPColorConstants.greenGradient1);
}
