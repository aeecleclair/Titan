import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class ColumnRefresher extends HookConsumerWidget {
  final List<Widget> children;
  final Future Function() onRefresh;
  const ColumnRefresher(
      {super.key, required this.onRefresh, required this.children});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb) {
      return ListView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          children: children);
    }
    return Platform.isAndroid ? buildAndroidList(ref) : buildIOSList(ref);
  }

  Widget buildAndroidList(WidgetRef ref) => LayoutBuilder(
        builder: (context, constraints) => RefreshIndicator(
          onRefresh: () async {
            tokenExpireWrapper(ref, onRefresh);
          },
          child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              children: children),
        ),
      );
  Widget buildIOSList(WidgetRef ref) => LayoutBuilder(
        builder: (context, constraints) => CustomScrollView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                tokenExpireWrapper(ref, onRefresh);
              },
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => children[index],
                  childCount: children.length),
            )
          ],
        ),
      );
}
