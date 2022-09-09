import 'package:flutter/material.dart';
import 'package:myecl/event/tools/constants.dart';
import 'package:myecl/tools/refresher.dart';

class EventRefresher extends Refresher {
  const EventRefresher(
      {Key? key, required Future Function() onRefresh, required Widget child})
      : super(
            key: key,
            onRefresh: onRefresh,
            child: child,
            col: EventColorConstants.blueGradient1);
}
