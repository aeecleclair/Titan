import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

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
      return child;
    } else {
      return Platform.isAndroid ? buildAndroidList(ref) : buildIOSList(ref);
    }
  }

  Widget buildAndroidList(WidgetRef ref) => RefreshIndicator(
      key: keyRefresh,
      onRefresh: () async {
        tokenExpireWrapper(ref, onRefresh);
      },
      child: child,
      color: AMAPColorConstants.gradient1);

  Widget buildIOSList(WidgetRef ref) => CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(onRefresh: () async {
              tokenExpireWrapper(ref, onRefresh);
            },
          ),
          SliverToBoxAdapter(child: child),
        ],
      );
}
