import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/drawer/providers/page_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';

class ModuleUI extends HookConsumerWidget {
  const ModuleUI({Key? key, required this.m, required this.controllerNotifier})
      : super(key: key);

  static Duration duration = const Duration(milliseconds: 200);

  final SwipeControllerNotifier controllerNotifier;
  final Module m;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(pageProvider);
    final pageNotifier = ref.watch(pageProvider.notifier);
    final hasScrolled = ref.watch(hasScrolledProvider.notifier);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      key: ValueKey(m.pos),
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        width: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 25,
                ),
                SizedBox(
                    height: 50,
                    child: Center(
                        child: Icon(
                      m.icon,
                      color: m.pos == page
                          ? DrawerColorConstants.selectedText
                          : DrawerColorConstants.lightText,
                    ))),
                Container(
                  width: 20,
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      m.name,
                      style: TextStyle(
                        color: m.pos == page
                            ? DrawerColorConstants.selectedText
                            : DrawerColorConstants.lightText,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        pageNotifier.setPage(m.pos);
        if (m.pos != 1) {
          hasScrolled.setHasScrolled(false);
        }
      },
      onDoubleTap: () {
        pageNotifier.setPage(m.pos);
        controllerNotifier.toggle();
        if (m.pos != 1) {
          hasScrolled.setHasScrolled(false);
        }
      },
    );
  }
}
