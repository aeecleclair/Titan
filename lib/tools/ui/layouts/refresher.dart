import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class Refresher extends HookConsumerWidget {
  final Widget child;
  final Future Function() onRefresh;
  final ScrollController? controller;
  const Refresher({
    super.key,
    required this.onRefresh,
    required this.child,
    this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb) {
      return SingleChildScrollView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: child,
      );
    }
    return Platform.isAndroid ? buildAndroidList(ref) : buildIOSList(ref);
  }

  Widget buildAndroidList(WidgetRef ref) => LayoutBuilder(
    builder: (context, constraints) => RefreshIndicator(
      onRefresh: () async {
        tokenExpireWrapper(ref, onRefresh);
      },
      child: SingleChildScrollView(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: child,
        ),
      ),
    ),
  );
  Widget buildIOSList(WidgetRef ref) => LayoutBuilder(
    builder: (context, constraints) => CustomScrollView(
      controller: controller,
      shrinkWrap: false,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            tokenExpireWrapper(ref, onRefresh);
          },
        ),
        SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        ),
      ],
    ),
  );
}
