import 'package:flutter/material.dart';
import 'package:myecl/home/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';

class HomeRefresher extends Refresher {
  const HomeRefresher(
      {Key? key, required Future Function() onRefresh, required Widget child})
      : super(
            key: key,
            onRefresh: onRefresh,
            child: child,
            col: HomeColorConstants.lightBlue);
}
