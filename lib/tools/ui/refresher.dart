import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class Refresher extends HookConsumerWidget {
  final Widget child;
  final Future Function() onRefresh;
  const Refresher({
    Key? key,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      ConstrainedBox constrainedBox = ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: child);
      if (kIsWeb) {
        return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: constrainedBox);
      }
      return Platform.isAndroid
          ? buildAndroidList(ref, constrainedBox)
          : buildIOSList(ref, constrainedBox);
    });
  }

  Widget buildAndroidList(WidgetRef ref, ConstrainedBox constrainedBox) =>
      RefreshIndicator(
        onRefresh: () async {
          tokenExpireWrapper(ref, onRefresh);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: constrainedBox,
        ),
      );
  Widget buildIOSList(WidgetRef ref, ConstrainedBox constrainedBox) =>
      CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              tokenExpireWrapper(ref, onRefresh);
            },
          ),
          SliverToBoxAdapter(
              child: constrainedBox),
        ],
      );
}
