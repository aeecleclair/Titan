import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/tokenExpireWrapper.dart';

class Refresher extends HookConsumerWidget {
  final Widget child;
  final GlobalKey<RefreshIndicatorState> keyRefresh;
  final Future Function() onRefresh;
  final Color col;
  const Refresher({
    Key? key,
    required this.keyRefresh,
    required this.onRefresh,
    required this.child,
    required this.col,
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
      color: col);

  Widget buildIOSList(WidgetRef ref) => CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              tokenExpireWrapper(ref, onRefresh);
            },
          ),
          SliverToBoxAdapter(child: child),
        ],
      );
}
