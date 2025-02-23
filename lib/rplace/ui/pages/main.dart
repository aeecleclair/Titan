import 'package:flutter/material.dart';
import 'package:myecl/rplace/ui/canvas_viewer.dart';
import 'package:myecl/tools/ui/widgets/top_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/rplace/router.dart';

class rPlacePage extends HookConsumerWidget {
  const rPlacePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(
      child: Column(
        children: [
          TopBar(
            title: "rPlace",
            root: rPlaceRouter.root,
          ),
          Expanded(child: CanvasViewer()),
        ],
      ),
    );
  }
}
