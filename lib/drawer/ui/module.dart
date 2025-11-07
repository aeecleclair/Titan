import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/drawer/class/module.dart';
import 'package:titan/drawer/providers/animation_provider.dart';
import 'package:titan/drawer/providers/swipe_provider.dart';
import 'package:titan/drawer/tools/constants.dart';
import 'package:titan/home/providers/scrolled_provider.dart';
import 'package:titan/home/router.dart';
import 'package:titan/tools/providers/path_forwarding_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ModuleUI extends HookConsumerWidget {
  const ModuleUI({super.key, required this.module});

  static Duration duration = const Duration(milliseconds: 200);
  final Module module;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pathForwardingNotifier = ref.read(pathForwardingProvider.notifier);
    final pathForwarding = ref.watch(pathForwardingProvider);
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
                Container(width: 20),
                Center(
                  child: module.getIcon(
                    module.root == pathForwarding.path
                        ? DrawerColorConstants.selectedText
                        : DrawerColorConstants.lightText,
                  ),
                ),
                Container(width: 20),
                SizedBox(
                  height: 50,
                  width: 130,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      module.name,
                      maxLines: 1,
                      minFontSize: 14,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: module.root == pathForwarding.path
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
        pathForwardingNotifier.forward(module.root);
        if (animation != null) {
          final controllerNotifier = ref.watch(
            swipeControllerProvider(animation).notifier,
          );
          controllerNotifier.toggle();
        }
        if (pathForwarding.path != HomeRouter.root) {
          hasScrolled.setHasScrolled(false);
        }
      },
    );
  }
}
