import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/cinema/providers/main_page_index_provider.dart';
import 'package:myecl/cinema/providers/scroll_provider.dart';
import 'package:myecl/cinema/router.dart';
import 'package:myecl/cinema/tools/constants.dart';
import 'package:myecl/tools/ui/top_bar.dart';
import 'package:qlevar_router/qlevar_router.dart';

class CinemaTemplate extends HookConsumerWidget {
  final Widget child;
  const CinemaTemplate({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialPageNotifier = ref.watch(mainPageIndexProvider.notifier);
    final scrollNotifier = ref.watch(scrollProvider.notifier);
    return (QR.currentPath != CinemaRouter.root + CinemaRouter.detail)
          ? SafeArea(
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
                  Expanded(child: child)
                ],
              ),
            )
          : child;
  }
}
