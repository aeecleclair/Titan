import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/cinema/router.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class CinemaTemplate extends HookConsumerWidget {
  final Widget child;
  const CinemaTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: ColorConstants.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TopBar(
            root: CinemaRouter.root,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
