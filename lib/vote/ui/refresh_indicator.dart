import 'package:flutter/material.dart';
import 'package:myecl/tools/refresher.dart';
import 'package:myecl/vote/tools/constants.dart';

class VoteRefresher extends Refresher {
  const VoteRefresher(
      {Key? key, required Future Function() onRefresh, required Widget child})
      : super(
          key: key,
          onRefresh: onRefresh,
          child: child,
          col: VoteColorConstants.green5,
        );
}
