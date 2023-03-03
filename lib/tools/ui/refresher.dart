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
    if (kIsWeb) {
      return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          child: child);
    } else {
      return Platform.isAndroid ? buildAndroidList(ref) : buildIOSList(ref);
    }
  }

  Widget buildAndroidList(WidgetRef ref) => LayoutBuilder(
        builder: (context, constraints) => RefreshIndicator(
          onRefresh: () async {
            tokenExpireWrapper(ref, onRefresh);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: child),
          ),
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
            SliverToBoxAdapter(
                child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: child)),
          ],
        ),
      );
}