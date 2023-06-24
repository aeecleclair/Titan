import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/router.dart';
import 'package:myecl/amap/tools/constants.dart';
import 'package:myecl/drawer/providers/swipe_provider.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TopBar extends HookConsumerWidget {
  final SwipeControllerNotifier controllerNotifier;
  const TopBar({Key? key, required this.controllerNotifier}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70,
              child: Builder(
                builder: (BuildContext appBarContext) {
                  return IconButton(
                      onPressed: () {
                        if (QR.currentPath == AmapRouter.root) {
                          controllerNotifier.toggle();
                        } else {
                          QR.back();
                        }
                      },
                      icon: HeroIcon(
                        QR.currentPath == AmapRouter.root
                            ? HeroIcons.bars3BottomLeft
                            : HeroIcons.chevronLeft,
                        color: Colors.black,
                        size: 30,
                      ));
                },
              ),
            ),
            const Text(
              AMAPTextConstants.amap,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 70,
              child: QR.currentPath == AmapRouter.root
                  ? IconButton(
                      onPressed: () {
                        QR.to(AmapRouter.root + AmapRouter.presentation);
                      },
                      icon: const HeroIcon(
                        HeroIcons.informationCircle,
                        color: Colors.black,
                        size: 40,
                      ))
                  : Container(),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
