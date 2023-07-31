import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/drawer/class/module.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:myecl/drawer/tools/constants.dart';
import 'package:myecl/home/providers/scrolled_provider.dart';
import 'package:myecl/home/router.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ModuleUI extends HookConsumerWidget {
  const ModuleUI({Key? key, required this.m, required this.controllerNotifier})
      : super(key: key);

  static Duration duration = const Duration(milliseconds: 200);

  final SwipeControllerNotifier controllerNotifier;
  final Module m;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasScrolled = ref.watch(hasScrolledProvider.notifier);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      key: ValueKey(m.root),
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
                        child: m.icon.fold(
                      (heroIcon) => HeroIcon(
                        heroIcon,
                        color: m.root == QR.currentPath
                            ? DrawerColorConstants.selectedText
                            : DrawerColorConstants.lightText,
                      ),
                      (svgPath) => SvgPicture.asset(svgPath,
                          colorFilter: ColorFilter.mode(
                              m.root == QR.currentPath
                                  ? DrawerColorConstants.selectedText
                                  : DrawerColorConstants.lightText,
                              BlendMode.srcIn)),
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
                        color: m.root == QR.currentPath
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
        QR.to(m.root);
        controllerNotifier.toggle();
        if (QR.currentPath != HomeRouter.root) {
          hasScrolled.setHasScrolled(false);
        }
      },
    );
  }
}
