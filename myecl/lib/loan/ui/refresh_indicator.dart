import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/loan/tools/constants.dart';

class Refresh extends HookConsumerWidget {
  final Widget child;
  final GlobalKey<RefreshIndicatorState> keyRefresh;
  final Future Function() onRefresh;
  const Refresh({
    Key? key,
    required this.keyRefresh,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb) {
      return Container(
        child: child,
      );
    } else {
      return Platform.isAndroid ? buildAndroidList() : buildIOSList();
    }
  }

  Widget buildAndroidList() => RefreshIndicator(
      key: keyRefresh,
      onRefresh: onRefresh,
      child: child,
      color: LoanColorConstants.darkGrey);

  Widget buildIOSList() => CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(onRefresh: onRefresh),
          SliverToBoxAdapter(child: child),
        ],
      );
}
