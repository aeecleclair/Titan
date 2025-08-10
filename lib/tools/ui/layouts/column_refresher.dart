import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/navigation/ui/scroll_to_hide_navbar.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ColumnRefresher extends ConsumerWidget {
  final List<Widget> children;
  final Future Function() onRefresh;
  final ScrollController controller;
  const ColumnRefresher({
    super.key,
    required this.onRefresh,
    required this.children,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb) {
      return ScrollToHideNavbar(
        controller: controller,
        child: ListView.builder(
          itemCount: children.length,
          itemBuilder: (BuildContext context, int index) => children[index],
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
        ),
      );
    }
    return Platform.isAndroid ? buildAndroidList(ref) : buildIOSList(ref);
  }

  Widget buildAndroidList(WidgetRef ref) => RefreshIndicator(
    onRefresh: () async {
      tokenExpireWrapper(ref, onRefresh);
    },
    child: ScrollToHideNavbar(
      controller: controller,
      child: ListView.builder(
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) => children[index],
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
      ),
    ),
  );
  Widget buildIOSList(WidgetRef ref) => ScrollToHideNavbar(
    controller: controller,
    child: CustomScrollView(
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
            childCount: children.length,
          ),
        ),
      ],
    ),
  );
}
