import 'package:flutter/material.dart';
import 'package:myecl/tools/refresher.dart';

class SettingsRefresher extends Refresher {
  const SettingsRefresher(
      {Key? key,
      required Future Function() onRefresh,
      required Widget child})
      : super(
            key: key,
            onRefresh: onRefresh,
            child: child,
            col: const Color(0xFF32a3f3));
}
