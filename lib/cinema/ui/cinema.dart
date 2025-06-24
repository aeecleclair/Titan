import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/cinema/providers/main_page_index_provider.dart';
import 'package:titan/cinema/providers/scroll_provider.dart';
import 'package:titan/cinema/router.dart';
import 'package:titan/cinema/tools/constants.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';

class CinemaTemplate extends HookConsumerWidget {
  final Widget child;
  const CinemaTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialPageNotifier = ref.watch(mainPageIndexProvider.notifier);
    final scrollNotifier = ref.watch(scrollProvider.notifier);
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TopBar(
            title: CinemaTextConstants.cinema,
            root: CinemaRouter.root,
            onMenu: () {
              initialPageNotifier.reset();
              scrollNotifier.reset();
            },
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
