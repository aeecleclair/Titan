import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/drawer/providers/animation_provider.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';
import 'package:myecl/home/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ModuleUI extends HookConsumerWidget {
  static Duration duration = const Duration(milliseconds: 200);
  final Module module;

  const ModuleUI({Key? key, required this.module}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasScrolled = ref.watch(hasScrolledProvider.notifier);
    final animation = ref.watch(animationProvider);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      key: ValueKey(module.root),
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
                Center(
                    child: module.getIcon(module.root == QR.currentPath
                        ? DrawerColorConstants.selectedText
                        : DrawerColorConstants.lightText)),
                Container(
                  width: 20,
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      module.name,
                      style: TextStyle(
                        color: module.root == QR.currentPath
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
        QR.to(module.root);
        if (animation != null) {
          final controllerNotifier =
              ref.watch(swipeControllerProvider(animation).notifier);
          controllerNotifier.toggle();
        }
        if (QR.currentPath != HomeRouter.root) {
          hasScrolled.setHasScrolled(false);
        }
      },
    );
  }
}
